Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530173;
	b=ckDXohCP57x2pxYL/6N0OgzbR550BRPRNjbWRWJo2kOd2y2q5QBLRGvrgodtSq/kn+fM
	 NC8pPUgZBjWXDY6Wp+cxI/YTWIzBYSCRdnab6eUVAKYHWNAz79qSuRcKW6C5v3e6NXVeB
	 e1qiRib9YnUFRtfzzwp34v1O4O24ZHC1rnnOJytstzn2t82I40fOoQF4XWlQahgoD6CFL
	 twDbaq5yH/zYjrOy68HMoVXbq95tcwCTzM34Bm6AgoszPcRgw3JLzCFJEONYqXmuQi0Xt
	 FhrcBBTg0Yu6dYVIKzu9IhTvrjhFM2C9gO9O0X5v5J1g3aTSS2Yjr1fjFlygJR7mMqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530173;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dfVi1epq9UkK+w0OrdxFEAO5Nv8em1V4aQyeWJba0B4=;
	b=kfAhHaA3FkB4+oeScaIjSVAqnuz/iYiGRI1f53ak6ujXppzbgJJzzO0sPYTS1+gezXB4
	 vOi8y//HQImUBKxwarugJGdpQf7Yyta5KcfATrZUBgcjA8F+GJR1lxSNHRd5p415DXs++
	 EjrFEXfBkjqi0OzSZz86sV3TRsEhPmKfCrg7v8BC7Jd9mi5Mp4MWcI8i5xtkPJNW7eH/N
	 h+3POP4ZqgS/yQC8p1axIU6wrcVNWufOiIHFNrbc7bP7WEueakfs/KPVugEC1OO3607ij
	 bJzIhpBWWYP08ui8eAcAZPlA+aV4Q+ptC7amTn7lZuTXMXrgf9Nox/f7IHsHEc5nJNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYU9qw0D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E400606A321;
	Tue, 24 Nov 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYU9qw0D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534031F000C6;
	Tue, 24 Nov 2026 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795530172;
	bh=dfVi1epq9UkK+w0OrdxFEAO5Nv8em1V4aQyeWJba0B4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bYU9qw0DDdxjJ1cU/xPFmK8u4Jn3ttMA0d32ejkpf3NxOI4sdG4W1PCR+Rv7+0pkj
	 39CNCbFZP+e7y0Mr0g/oGipkchON+FJBkwiFfOzr3m8Tnh9z5ZSO9f8ISKvkqQvXZb
	 si/HxYk8fFqV6gy4apNz8RSAZWwEfepRawUHDL1Bt1LZlxdYmCwrbqIRJ/Pk69bxwx
	 TSKRGWYadrtKIbZHnRsK+J4STgfVAcSAmMrHA8U6ATuMk3/zCI3cJXc39oZDSTIx6u
	 6sNWKGjWK+d4VasEIsf33805Hh/+53hZsiS3GYfZBtRcSHo1DS1ICJmTC+ksDPJdNC
	 b8dvMNZeimusQ==
Date: Tue, 24 Nov 2026 04:22:51 -1000
Message-ID: <c7245b367e0ab9ff71222607749b7b6c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com, stable@vger.kernel.org, JaeJoon Jung <rgbi3307@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Don't request private stacks the JIT can't provide
In-Reply-To: <20261123145450.12725-2-yphbchou0911@gmail.com>
References: <20261123145450.12725-2-yphbchou0911@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes with the following changes:

- bpf_scx_check_member() wraps the switch in an if block instead of
  returning early, which made the function fragile.

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9308,15 +9308,17 @@ static int bpf_scx_check_member(const struct btf_type *t,
 	 * sub-scheds and sub-scheds themselves but I don't know how to access
 	 * struct_ops from here.
 	 */
-	switch (moff) {
-	case offsetof(struct sched_ext_ops, dispatch):
-		prog->aux->priv_stack_requested = true;
-		prog->aux->recursion_detected = scx_pstack_recursion_on_dispatch;
-		break;
-	case offsetof(struct sched_ext_ops, sub_caps_updated):
-		prog->aux->priv_stack_requested = true;
-		prog->aux->recursion_detected = scx_pstack_recursion_on_caps_updated;
-		break;
+	if (bpf_jit_supports_private_stack()) {
+		switch (moff) {
+		case offsetof(struct sched_ext_ops, dispatch):
+			prog->aux->priv_stack_requested = true;
+			prog->aux->recursion_detected = scx_pstack_recursion_on_dispatch;
+			break;
+		case offsetof(struct sched_ext_ops, sub_caps_updated):
+			prog->aux->priv_stack_requested = true;
+			prog->aux->recursion_detected = scx_pstack_recursion_on_caps_updated;
+			break;
+		}
 	}
 #endif	/* CONFIG_EXT_SUB_SCHED */

Thanks.

--
tejun
