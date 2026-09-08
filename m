Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C3538D73;
	Tue,  8 Sep 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877760; cv=none; b=NFCBY1sZ2u/OTIR0gRFUU/LWSRiN7CzgdBDJx1OozkdxsoIl6zJdJ8OQhXLfiBZWNAY1Vqft+gDfyXHIS7OlBo6lvbTAl+6QEPscEeLkdgGd+wSVzf7nt1/5Sj9yS8foBE0txUjGeMBJ4tQ5jK4JzJBIULbilH09XytIIOPClig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877760; c=relaxed/simple;
	bh=5V0Cw5Qhc4VFggEnMwC/ejRxL+INGZDaVd9TR2wLQoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jwbVBNJh1l8Ueb9LXLke0dml30tjqT8KQbCVKtA1kWEXDXkgnWp7aK6NL9auc+ypTuNNy178sADyd8sJ7S9xbJliRTgf0bvXMJWKSzRcuzMTeBQHZiQgWh8pMstUekVEKT5Yi1C0P06aW51TmBhWQZRJhvC+U+aUwB1FR4/ypTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GPOm7smE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GPOm7smE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1BF504E41597;
	Tue,  8 Sep 2026 14:29:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA5F3603C4;
	Tue,  8 Sep 2026 14:28:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2813B11C7AF4F;
	Tue,  8 Sep 2026 16:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788877738; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=LQ72/bwE87PZI8NiplH/juFfXWziTHdYYN6vw5Uubd0=;
	b=GPOm7smEXgBYp1RioQ8yoppNqo4JR6IXrN7iJNWkhqVEchehSF6TTaqjUsaMhpTw038Jtt
	nGlkNhX+4T/i2VGt6APJUVkvb4bquu0fj5joxHaEowRhSLKUYwzr+RHVOW5vMkpTfjF92i
	xvmhycbOvgk79KyiTJO17knXPSD1VJVlmtqqxBep2w9x0+exl75bTWWWbYNUJYuhByK015
	G3YF/vpbfdPda2ppUpg+WBJMOmhtUCDBvShTNLHax1e+nKfgbQa5T+pYcZWCgY2h0jQ3Ce
	P9nYevjg5d/94EX+UMdvi5Letb1s975SRD0HMVC8pprf/us+EIHi8D9Ifi/aSw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 08 Sep 2026 16:28:48 +0200
Subject: [PATCH 5.10.y] bpf: Enforce expected_attach_type for tailcall
 compatibility
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-cve-2025-40123-v1-1-be62451196fb@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBCF4VchZ82QaaHcXsW40DrqsADSItEQ3
 t2Ky+8k598QJahE9NmGIKtGncYEk2fwz8v4ENJbMizbmjtuyK9CCY4qNrYk4barW3YNlxbpNAe
 56/sInuAKw8UH5/8eX9dB/PKrYd+/Wi36/3oAAAA=
X-Change-ID: 20260907-cve-2025-40123-e08968057032
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Andrey Ignatov <rdna@fb.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Dongliang Mu <dzm91@hust.edu.cn>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788877730; l=4173;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=i0nrpJeTUlNnEvoKERik/V/VV4CvIxY4hKcVnixWGZw=;
 b=z9wX5y24mP4XRwy0YNfVpo5RNdvBNvc2EvOzmNLulLPeoqlM8ZA7ZWX6dvXYHvCGEEh9Yz2iE
 ee+leegl5fECaCeoHv4a/t45iL2+5W5EAmsBzhS9s1Xy3hE5FO9sUdA
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 4540aed51b12bc13364149bf95f6ecef013197c0 ]

Yinhao et al. recently reported:

  Our fuzzer tool discovered an uninitialized pointer issue in the
  bpf_prog_test_run_xdp() function within the Linux kernel's BPF subsystem.
  This leads to a NULL pointer dereference when a BPF program attempts to
  deference the txq member of struct xdp_buff object.

The test initializes two programs of BPF_PROG_TYPE_XDP: progA acts as the
entry point for bpf_prog_test_run_xdp() and its expected_attach_type can
neither be of be BPF_XDP_DEVMAP nor BPF_XDP_CPUMAP. progA calls into a slot
of a tailcall map it owns. progB's expected_attach_type must be BPF_XDP_DEVMAP
to pass xdp_is_valid_access() validation. The program returns struct xdp_md's
egress_ifindex, and the latter is only allowed to be accessed under mentioned
expected_attach_type. progB is then inserted into the tailcall which progA
calls.

The underlying issue goes beyond XDP though. Another example are programs
of type BPF_PROG_TYPE_CGROUP_SOCK_ADDR. sock_addr_is_valid_access() as well
as sock_addr_func_proto() have different logic depending on the programs'
expected_attach_type. Similarly, a program attached to BPF_CGROUP_INET4_GETPEERNAME
should not be allowed doing a tailcall into a program which calls bpf_bind()
out of BPF which is only enabled for BPF_CGROUP_INET4_CONNECT.

In short, specifying expected_attach_type allows to open up additional
functionality or restrictions beyond what the basic bpf_prog_type enables.
The use of tailcalls must not violate these constraints. Fix it by enforcing
expected_attach_type in __bpf_prog_map_compatible().

Note that we only enforce this for tailcall maps, but not for BPF devmaps or
cpumaps: There, the programs are invoked through dev_map_bpf_prog_run*() and
cpu_map_bpf_prog_run*() which set up a new environment / context and therefore
these situations are not prone to this issue.

[ Fixed conflict, applied the changes to bpf_prog_array_compatible
instead of __bpf_prog_map_compatible. Dropped the guard testing for
BPF_MAP_TYPE_PROG_ARRAY as bpf_prog_array_compatible is only called on maps whose
map_type is already BPF_MAP_TYPE_PROG_ARRAY, so the check was always true ]

Fixes: 5e43f899b03a ("bpf: Check attach type at prog load time")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20250926171201.188490-1-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/core.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5d5d0bc7ca50..fb213524ccac 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -876,6 +876,7 @@ struct bpf_array_aux {
 		spinlock_t lock;
 		enum bpf_prog_type type;
 		bool jited;
+		enum bpf_attach_type expected_attach_type;
 	} owner;
 	/* Programs with direct jumps into programs part of this array. */
 	struct list_head poke_progs;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index db613a97ee5f..c9b3fe8b250a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1795,10 +1795,14 @@ bool bpf_prog_array_compatible(struct bpf_array *array,
 		 */
 		array->aux->owner.type  = fp->type;
 		array->aux->owner.jited = fp->jited;
+		array->aux->owner.expected_attach_type = fp->expected_attach_type;
 		ret = true;
 	} else {
 		ret = array->aux->owner.type  == fp->type &&
 		      array->aux->owner.jited == fp->jited;
+		if (ret &&
+		    array->aux->owner.expected_attach_type != fp->expected_attach_type)
+			ret = false;
 	}
 	spin_unlock(&array->aux->owner.lock);
 	return ret;

---
base-commit: 2a3da1f4966798b0b48ce302944ad356b2c98b5d
change-id: 20260907-cve-2025-40123-e08968057032

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

