Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6B3AFB06
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682087; cv=none; b=KUXgH+RHXl+bMdKpgPkIRD/Ku+RHqpCp0qxct+1ipssu3DeIKrNdU1B0O0Fvh9OSe/NJJPSUco4Ky13H80FeFmCD2c5vp2IHjmcgFP3JaIa5C9pydum8nkydQ89C4n8EqDmYh+Ie+iaIkVCBYC4V1fSdZbfEKPwhX+SEtoLctgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682087; c=relaxed/simple;
	bh=QETLz/SiAZL87RiG+peYej8r+Kym6gkw079QO1N7TF8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r1rZaic7v1CQtpE8fAuvpiKujeYNonf2aaLoq+FiiHR7Fc4v/Rd5CaljRfpWlkMydAXRkZnGWTEm14mGBqSGbv30oloerEXd1bQIqkNWQzuczUtouBgk2qpfvnnSUYUJVcxGeJ/f4sLRCp10xA3DtI/ujzahYNvZkiRhcYsQT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUk5lhbE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUk5lhbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26711F000FF;
	Tue, 29 Sep 2026 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682086;
	bh=J5rxrpsq13jVEvMb9m6NV+D52bp5KY/1blvNGWy26Mg=;
	h=Subject:To:Cc:From:Date;
	b=MUk5lhbEeoqhk73j9VvvmONj+vZ0+OUU/7WsRUkryR91E7pYzi5GMpDlu7Bq3zzQ6
	 Lw70+K7omoWKW16cvPxrH49pXzsQ7J4yC4iRjIdw9alSWetAlh4IZl7cb/2JPX9q1M
	 pznfH/koKacBtLhDqiisMhobcvr2LSLFoIqw5Tek=
Subject: FAILED: patch "[PATCH] RISC-V: KVM: Fix sdata leak and stale snapshot_addr in" failed to apply to 6.18-stable tree
To: zhouzongmin@kylinos.cn,anup@brainfault.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:41:10 +0200
Message-ID: <2026092910-onslaught-tinwork-1a6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b7749531a9b195f4fd7db92ca3cc49bda1a4dc8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092910-onslaught-tinwork-1a6b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

