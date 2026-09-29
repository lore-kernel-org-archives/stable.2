Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397251616A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682076; cv=none; b=sPXAYQftAourg8iLydbv59K7eTXvVD3zT1qx3rPxl06+RD5H6Y8DmpYySLtuL3o+u+aI2NDiHoC7oGb56QdMFGYwZm93O5F3NWktkCQvfkFUjaC2wQefP3K629zcgflu0FQXKeyViS3uWOT6eP4EbTzjQ8ek7gZDAlIIY9sN+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682076; c=relaxed/simple;
	bh=wYVbLIE60+kAG39oJAcosv2g7Af+A0T+GoWW6lSh90U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aQuDuQiPQnsCWsDeIPk9r054Y4My+dGval+FowEqJOsOZK2BouX9KInBzCwxo4XuPw98rMW/pre2BKFpsKf2lYEF+VZIKwcHOOaiia6ae+V/juHIQvOW4inHPicFkwca+akGurtn2TMKK18sibmjbuG7BKSGZjgmnqHSd/6dDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H834hkSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H834hkSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82D11F000FF;
	Tue, 29 Sep 2026 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682075;
	bh=dsSFojVEctXHvDcVEMeYBJkHuTiv0s6kO+Eeh5YkuVM=;
	h=Subject:To:Cc:From:Date;
	b=H834hkSN84UlGIWAJqpFlxTsZdz6G9FjFfAXVLYHrp0SHuHBQHiFtZbsM6tmygHil
	 MxumbHKajzyaRvI9y6cyOweQFMXDFfVHdlgH7g1JUvsuPvj3Se5pl8VYkHOEllcqfu
	 OkwS2pJ5GC5UeufGZj2FZJ6cRSOVBW6sKsd3V158=
Subject: FAILED: patch "[PATCH] RISC-V: KVM: Fix sdata leak and stale snapshot_addr in" failed to apply to 7.2-stable tree
To: zhouzongmin@kylinos.cn,anup@brainfault.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:41:09 +0200
Message-ID: <2026092909-encrypt-stainless-6564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x b7749531a9b195f4fd7db92ca3cc49bda1a4dc8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092909-encrypt-stainless-6564@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b7749531a9b195f4fd7db92ca3cc49bda1a4dc8d Mon Sep 17 00:00:00 2001
From: Zongmin Zhou <zhouzongmin@kylinos.cn>
Date: Wed, 26 Aug 2026 14:41:17 +0800
Subject: [PATCH] RISC-V: KVM: Fix sdata leak and stale snapshot_addr in
 snapshot_set_shmem

A guest may call SBI_PMU_SNAPSHOT_SET_SHMEM repeatedly. Each call
overwrites kvpmu->sdata without freeing the old buffer (memory leak),
and if a later kvm_vcpu_write_guest() fails, the error path frees
sdata but leaves snapshot_addr stale. A subsequent
SBI_PMU_COUNTER_START then passes the INVALID_GPA check and crashes
the host with a NULL buffer in kvm_vcpu_read_guest().

Fix this by clearing the previously installed snapshot area before
installing a new one, which keeps sdata and snapshot_addr consistent.
The SBI spec suggests a single invocation but defines no error code
for repeated calls, so KVM must tolerate them.

Fixes: c2f41ddbcdd756 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
Cc: stable@vger.kernel.org
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20260826064117.58029-1-min_halo@163.com
Signed-off-by: Anup Patel <anup@brainfault.org>

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 6ff741ee7803..cc0c138651bc 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -454,6 +454,14 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 		}
 	}
 
+	/*
+	 * Clear any previously installed snapshot area to avoid leaking
+	 * the old sdata and to keep sdata/snapshot_addr consistent if
+	 * the re-install fails below.
+	 */
+	if (kvpmu->snapshot_addr != INVALID_GPA)
+		kvm_pmu_clear_snapshot_area(vcpu);
+
 	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!kvpmu->sdata) {
 		sbiret = SBI_ERR_FAILURE;

