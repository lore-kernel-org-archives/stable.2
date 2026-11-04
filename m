Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799676;
	b=ngkk63OfD57dwAfNth1X+UuLxM1MLZodVag1ATgmplpc6z8EkkcFIxw4s9KKlSYWGBZx
	 1e5xbjtzHZiOpVzKGP4fDx70S7Y8HvHi5NzaDth3BGoN3jRzGaVtbRE0ipsAtjrtncasj
	 OvAD5UIGWWgSLRLcIg6t4GVBH3MVQ9c6rspU71dS7D3YhQUtZRDkWLUsIK6DowT8l8Aw/
	 M/XFf+qy3LGLJsFJDTRjxx+A5lpAN0QKMzi7FpJUhoWa9noc55+ExYilY04QfmNwtqc+a
	 vbPfCkzvVrLxIvFdf29WiQUykIubvAM+15oNWmdhNngX4eDK5zQ4dgvTlovwccu6DxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799676;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2ReybQHqeeC3dYeKo2oMPZgwMFbJNhVQU8D6YjrOVIQ=;
	b=QH9C/26zFSlUS+yaB2zXjHcC/GAuzzgJw2XX7YJkIFqubKHBStfY1PF0hY1/LpNJqZxU
	 G4ua3i93WsENbXbuO4Va89SOonsmIrjx3av2DSTQqOyxT9YBoVN8yn0qRWGmqRMITvpFk
	 BqUYjBlCFqPSwaKMlbwWoD/kbbj1sldN/9a2AooXxmpprHxIy8AQlCPzOLIT8nBy2oYnm
	 NIDyhNFzOlGAS+bXSvym/MJriQZbzYilcxNNGzcSGkusb6iozH2Lo0+ospgGlfvOl007C
	 CTz0fcfK1DDrz4eRc613xWIsgPdkDbKRy5EGd1mpylwNYiCOdOEa52iUrDJCHPYZJrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bpgi0IVK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A375606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bpgi0IVK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29641F00A02;
	Wed,  4 Nov 2026 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799676;
	bh=2ReybQHqeeC3dYeKo2oMPZgwMFbJNhVQU8D6YjrOVIQ=;
	h=Subject:To:Cc:From:Date;
	b=bpgi0IVKoqE7F2NznANbaol8hXdgKC5UKOz1R0UTkA885O6gySn7DGCNh80znRVUr
	 bW+TCqcHLl+o40S8Id2ey0HQk1FdbOoEzSOHlNV0xWEKcabJOREyXLcB7nAI5ubBNm
	 wrn+g1AtzOShRXYHOjXIqS462zKLcsWquFHqkPwA=
Subject: FAILED: patch "[PATCH] s390/cpum_cf: Check session mask before cpu offline" failed to apply to 5.15-stable tree
To: sumanthk@linux.ibm.com,borntraeger@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:41:14 +0100
Message-ID: <2026110414-reliable-bonded-7e4b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 99a95985dfc85eecad97f0991a2401d2fcef294c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110414-reliable-bonded-7e4b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99a95985dfc85eecad97f0991a2401d2fcef294c Mon Sep 17 00:00:00 2001
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
Date: Tue, 6 Oct 2026 13:13:03 +0200
Subject: [PATCH] s390/cpum_cf: Check session mask before cpu offline

cfset_offline_cpu() stops counter sets for every active session without
checking whether the outgoing cpu belongs to the session mask.

For example, run an hwctr session on cpu0 and a cpu bound perf event on
cpu1:

lshwc -l 9999 -i 5 0:b
perf stat -C 1 -e cpum_cf/CPU_CYCLES/ sleep 120
chcpu -d 1
chcpu -e 1

Although the hwctr session does not include cpu1, cfset_offline_cpu()
decrements its counter set reference count. The subsequent perf teardown
decrements it again, causing it to underflow.

The perf event keeps the percpu state alive across hotplug. When cpu1
comes online, the hwctr session is started there and the reference count
moves from -1 to 0. Stopping the hwctr session then decrements it to -1
again, so the zero triggered counter set disable path is skipped.

Check the session mask before stopping counter sets on the outgoing cpu.
This prevents the unmatched decrement and the resulting reference count
underflow.

Fixes: a029a4eab39e ("s390/cpumf: Allow concurrent access for CPU Measurement Counter Facility")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 69fa303cd479..1d63dc3b0ab9 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1797,6 +1797,9 @@ static int cfset_offline_cpu(unsigned int cpu)
 
 	if (!list_empty(&cfset_session.head)) {
 		list_for_each_entry(rp, &cfset_session.head, node) {
+			if (!cpumask_test_cpu(cpu, &rp->mask))
+				continue;
+
 			p.sets = rp->ctrset;
 			cfset_ioctl_off(&p);
 			cpumask_clear_cpu(cpu, &rp->mask);

