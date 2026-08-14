Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297E45A286
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712843; cv=none; b=ti36VB7HR73KpL3+U70zuVeTGqM2B363VN16pLNnGblqj6NcCFe6Ecshc9jYuwX8cKs4y0vEo5D4SUsLgVGHhdP1bnke3KqIPOQLLKdfz9nfKN+9S2Z/gbEsHzDxL39O9K0Ck/wj5l+i0iE4UYjq2vj8wKYl6ipeFMBKe+D1fMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712843; c=relaxed/simple;
	bh=HN+vZOnZNdBjJA8ewWe+twSaI7H37SXkAkiZmiM7rAs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Yg3PfR2V0ThIQPN5ISmr6MFuOXROxEdjil/YgiBrDiDQegU7U1opIWfqn26ozIHLq4BRioZZRixp7bV5ucr3kEQnXHyFPZQXwImh7Sft7ObI4iIXU8nCW52YERlxaotEg8KcqrBBdScZKYksE4cJ2Af0XEtUpL5H+RswMWdhodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=p39PFoyR; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p39PFoyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786712834; bh=CGJZ3mhCmb6ps0SxrZbn/tQPNBv5hW7W/5KI6w51kmY=;
	h=From:To:Cc:Subject:Date;
	b=p39PFoyR5j7UuUKqJOzJ9NkAroQW6WTS1vVky6cTxijx8wJjouynYS68S0A6fUX04
	 2mon3UNj+LG+rLvqGwuAoJt8p07qPNc6xkADtb7MGYKIvJQIdbDB457M/TC7Tr1K0h
	 wzOuAz7XtPraPnCU31r2R8XHQlAgjrza7/Rqs+PI=
Received: from localhost.localdomain ([180.101.244.73])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 1BA2E89C; Fri, 14 Aug 2026 21:06:58 +0800
X-QQ-mid: xmsmtpt1786712818tuzb71q31
Message-ID: <tencent_2EB11B9074207E825BE3ACC0AF1F09DE0108@qq.com>
X-QQ-XMAILINFO: N/HBIA08JiWUwo7t0Shg0hi66hrLZCTmUNMBwp9L8lJoDe2gdTOE6opDbSYKU+
	 R2rQIW6qOT0FPVi/5QUK/glzUpyOnH4F3wDCjjMSNNftx/TsOMXBr6iOuySEejL+Vg5gmzaz4BGJ
	 NwLVMzgBAER7b/Fxg0Ns9G3TSqyCtnUcLdPumLAcceJLA31AxE6M97J9k4JpNHgsbNifAM1mLKv4
	 o8+9bdQSMSOD1yrSPMHOg/vymXS/W+5RlAGt/5AgpBBobPrCKaBXn8xPmJGTFIHrxHlGTVxLTKHU
	 tAGr0r8HVb0GCnSef+xXmaT3HraQn+Pw5A9WJQnCIfmaUTQKCkU6w6aWVZY/n8bmxglPui33z+f8
	 PS+s0jjsNeJ8pWQuS4VYxrtRW0Zai2hqPfNRBt0sqmIkWVTXZ/B9Nraq2ZrgqisXoitm/5nMejLz
	 /xOq4hpOGQ3Nj703E9rPJzPxEQe6pj2Ncv/+vfyqVt7arpEkPI9ReOEjTK605Kc6a4zU+d5QIw7e
	 laW6hVPL1nILQ2mYe4UMN+c+tr1Kj8HfeJ9KvsCL+JK4qe46sMmgD1oJHYd36dANN54t40d/rbl9
	 0AfzP05izOl0MFQDoBT18fxjeN0YUHZ2qGpLtL/qTNW2orK+Umku4Xo/WxZDc2S1C/85SfWC02tt
	 JmYIQcqQbIPT9tBZGpEvtoun6xnUO5rCdHgySMTn4AAWMyaRPOC+Gn4mcu/6o+MibQ6mGhgWjWk0
	 Zyi1bXB8IYyVmvxX5VsuBmDcYq/WGtqmdJlEpWJYb/axxgBY+LZL4p3TW9wnHT1w2LuDqo38xEYc
	 dTH9en8Vp/Y1JI/T5GJwkI0mOsl4rIxAkTnIJj3RwGAAmuR3XXq/dvCcNzlsAjknPsjOwwXuzaUH
	 ZZAdHkRvOHFn8cVB72rlEmSqLo9rcwNApzZTMxxLnW0cnM15vs6OZzNn2+mDVat702UgrDHf6gU1
	 uInocBw3l8BeasPksUHGln0yW+qhTXOMNfW0nsqhrgY4ds7bVC6HZcKu/AhC67
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Aohan Mei <3472274613@qq.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	zhuyifei@google.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	corvus@tencent.com,
	Aohan Mei <henrymei@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf: Enforce cgroup storage map consistency for freplace attach
Date: Fri, 14 Aug 2026 21:06:23 +0800
X-OQ-MSGID: <20260814130650.634992-1-3472274613@qq.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

When a BPF_PROG_TYPE_EXT program replaces a cgroup program, it
executes with the target's runtime context, including the per-program
cgroup storage descriptor attached to the cgroup prog item. The
verifier, however, bounds the extension's bpf_get_local_storage()
accesses by the extension's own storage map.

The prog-array path already enforces that programs sharing a
runtime storage context reference identical storage maps (via the
owner cookie matching added in commit abad3d0bad72 ("bpf: Fix oob
access in cgroup local storage")), but the freplace path performs
no such consistency check in bpf_freplace_check_tgt_prog(). An
extension whose storage map differs from the target's therefore
operates on a buffer whose layout does not match its verified
bounds.

Reject the freplace attach with -EINVAL when the extension and the
target program reference mismatched cgroup storage maps.

Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 kernel/bpf/trampoline.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..3743f6c25e2c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -806,9 +806,11 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
+static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog,
+				       struct bpf_prog *prog)
 {
 	struct bpf_prog_aux *aux = tgt_prog->aux;
+	enum bpf_cgroup_storage_type i;
 
 	guard(mutex)(&aux->ext_mutex);
 	if (aux->prog_array_member_cnt)
@@ -821,6 +823,20 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 		return -EBUSY;
 
 	aux->is_extended = true;
+
+	/* At runtime the extension program inherits the target program's
+	 * cgroup storage context (via prog_item->cgroup_storage), while the
+	 * verifier bounds its accesses by its own map's value_size. A
+	 * value_size mismatch leads to slab out-of-bounds access.
+	 */
+	for_each_cgroup_storage_type(i) {
+		struct bpf_map *tgt_map = tgt_prog->aux->cgroup_storage[i];
+		struct bpf_map *prog_map = prog->aux->cgroup_storage[i];
+
+		if (prog_map && (!tgt_map || prog_map->value_size != tgt_map->value_size))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -926,7 +942,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		/* Cannot attach extension if fentry/fexit are in use. */
 		if (cnt)
 			return -EBUSY;
-		err = bpf_freplace_check_tgt_prog(tgt_prog);
+		err = bpf_freplace_check_tgt_prog(tgt_prog, node->link->prog);
 		if (err)
 			return err;
 		tr->extension_prog = node->link->prog;
-- 
2.43.7

