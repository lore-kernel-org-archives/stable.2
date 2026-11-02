Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623039;
	b=rXDBs02H2+aU+Rzf0sR3JH3G2YVfpIBqNmxdD+go+vVJ5oJks2tpirKXIFosbYR+r6zb
	 UVfVeoSnvPTHmvVc+X52/hZGQQaILA8MmZbCreD89OxdhzBWMaSX0WOKFBSmUZ47c7Ipo
	 AHQ25JjwuWuvK/Baq8fkE96tg7WXaudnuoZuNa8FW3YnYGeq/+O0eb4WwYBOkbbRBVbzg
	 7u0lG8rjW19/npgTfUZ1f+zlmCqgm715TNVtkQfwZkoPpcFGPKvribTAc1HuIKOq6PahX
	 7Gy0FxMatWprFZ0WKQhu8scG5kgu68golx9tzOIF7UnTNgVS9yE9Ig3UyrPE0kAz42A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=UjBzccaJDDlTsbT7lY8oUdWUO7cHir5+ebQJXokkFqw=;
	b=OufFP21+2nJJNp1VHx9DvbSwIHFZfifzLV3gFQel/U0DpmePmT/Ijd409PSAuzITV85f
	 KVcd9az8giAG+mnfIuS3WWPgxngEpJSCE5T+6Q2fiCSy5vk6kqo8Zd2DJJfCzOfLnKMyF
	 Qe3A6m77NW7ugZvmqEgIR6ubZCgrB4rOCmisVHd/w9YyWqf8TEwVLePmtKbRH5STGrSAP
	 eBZ01jEMCOEfwXKjbk0SeLe7A3kXqbG31101F77D9qm8VxIuasjpPKUCfnveJF3zd5sTJ
	 z+H2QvDa7eMp6xxjaC8OTbc8dzSVLnN2mr3xPfQRL2pIOiZcLmLLZIKZ5DhGYK/qKgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pSdxvYEa;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD2606A337
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BFD2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pSdxvYEa
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5121976eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623039; x=1794227839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UjBzccaJDDlTsbT7lY8oUdWUO7cHir5+ebQJXokkFqw=;
        b=pSdxvYEaXJkhqfPlsGxTuQA2m33GSpJYR2vhxJa1+ZrYumZkFLUcuwchm9jpzrSNRk
         UzkKbt37f5AeVZHpA0d15xNQJgc94ZU58Y46J3sdd8FKUO5Kk1bUzEBBdJdHu5HdXhaN
         mzPw3lO2D5zHTVHDUbdCNJnLRaGAyAl2F/7RCeuadNwmLat9snzopuhLI4IU3/t0lpAg
         yz2z35wNTZ4H8KBMop0i+viOahduXqQhtKaAfrSvNOb66VIRms7VtvYBtSe5F2rcI7+H
         XySFS0sBj6W5c4YxpowSdI9lyo5UzRZXT4V2fPBa3/8AMsQAby9x/8gWLrHvkWLL2/xn
         mrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623039; x=1794227839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjBzccaJDDlTsbT7lY8oUdWUO7cHir5+ebQJXokkFqw=;
        b=odHTuFQfsVJOzdox+kX7iyeCS7/A7GPcR6MjKjmocWE+9njIye9ECstCtNPPqTphpK
         253/iN5Ol7HpRlWFrfE/7zDb4UskMLh4tlVIHxkye5CqOfK+tbBsnY6EpPxrwvlyxlRa
         4+csJymolrjYWxyZQw5Ky0oxWSrXOmoSPegRxDAavb86TDKI/U7yWA4Cbuk64rwsf7z9
         yu/CPFnNN0FW0KXSMl1mB6t9vqkJ4koo9bSK5YzgtFFrG7CY+s1bg+psvdgJYXdkWqj/
         Q5MnIC3OjCEfp912iFne9PnYXzfQJnYSO10hAlP7yd1UDwOwKDWzRnJCVLi1phWC3gDb
         1bkw==
X-Forwarded-Encrypted: i=1; AKwUvBz9P1HAVVF/0xZj7fNocL6NYPCnR+m+LZGmsacQH/B12aqKbThtJ4uHKI4KaCYxtw7xvLoiIDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fkhncNPpZLbQw8PVMxUZyhG69U91JwRvQZmJQ2TBgMDtWmoIk
	lsEWg7E8zTPqlJH1VA0yKmCRSZEy31G93BrLRUuvoCnboBu6uaS8UNM8
X-Gm-Gg: AYBFou21LHbaGmRGIlzygIO/A1EyUeaqE/k9CqhODyPeH4aEyqFOi+bMArC8KzlfMiA
	xavXncLKmfmYDrjXXikOVybbWQlzAe73zxK1I4ciYNeDVsGkHRU9ZrRsxCybd4khQJC1G8mAIUK
	QpJnk74UTuFeppHeQfheikOLC/2gKyZa2NerHXo3+FyHM2pTWQbXHVPPHR23it2fWu05cCX34/E
	np7wIEB2lJW2/24AfSi+e1oha/Kx+C7P4ngLogswH4DrwYZc2MpNl4toqceMqCWoTBAhvmSQzjC
	u7/41PdZ8EmqC5pz4Y7JXwhtkyexMwJJAzTP4k8mGRlHEWhjYeFNaCZqGvFWUNxnTUjCE6Bazwr
	HhOanYyQwaQ501P1BwRVY0H7xWiF7+Gc5prxk7Jk3kHw1aXMr/U0uxgg0FemNCmCvIy3o6mg4EQ
	qB4NySTepIoksKEveIjYayCm8aYGY7RMJ2s3D5bytrH9Vf5RQMBxRqSlHBqc2+aAkEmWkF2gvdW
	RLMCMQ5zyoRksi54Y0wUwrF8QLUvR+5Py0ooWBVbPDCXoq4s8Fd4guEtBnADSmmJ2uRNNhBtJLu
	Te9DN7G568225k5mEatjujvI
X-Received: by 2002:a05:693c:638e:20b0:366:703c:5ef8 with SMTP id 5a478bee46e88-36a423935f0mr16041785eec.7.1793623038614;
        Mon, 02 Nov 2026 04:37:18 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm36326095eec.6.2026.11.02.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:37:18 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 07:37:02 -0500
Subject: [PATCH bpf-next 2/5] bpf: Keep the barrier of a nospec insn when
 removing nops
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bpf-blind-nops-fixes-v1-2-844300e42cdb@gmail.com>
References: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
In-Reply-To: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, 
 Henriette Herzog <henriette.herzog@rub.de>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

When an insn is unsafe on a mispredicted path, the verifier marks it
nospec, and bpf_convert_ctx_accesses() puts a barrier in front of it.
The verifier doesn't check the mispredicted path beyond the insn.

bpf_opt_remove_nops() runs before that and doesn't look at the mark. A
conditional jump can be nospec, then become a 'goto' over dead code,
and then a nop. The pass removes it, and the barrier goes with it. Here
the jump behind 'r1 = 0' compared r1 = r10 on the mispredicted path, for
a prog loaded with CAP_BPF and without CAP_PERFMON:

  0: call unknown
  1: r0 &= 255
  2: r1 = 0
  3: r0 = 0
  4: exit

Don't take a nospec insn for a nop.

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Cc: stable@vger.kernel.org # 6.17+
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
For stable: before the patch list, opt_remove_nops() in verifier.c
removes 'ja 0' and 'may_goto +0'. Skip an insn whose aux data has nospec
there.
---
 kernel/bpf/fixups.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ead78713e04f4..0cc758749be9b 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -699,7 +699,8 @@ static bool insn_is_nop(struct bpf_verifier_env *env, int i, int next)
 {
 	struct bpf_insn insn = env->prog->insnsi[i];
 
-	if (env->insn_aux_data[i].indirect_target)
+	/* keep a nospec insn, the barrier in front of it must stay */
+	if (env->insn_aux_data[i].indirect_target || env->insn_aux_data[i].nospec)
 		return false;
 	if (insn.off < 0 || i + 1 + insn.off > next)
 		return false;

-- 
2.43.0

