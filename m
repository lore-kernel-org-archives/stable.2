Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590231;
	b=R23NfrFsqzWG3kzEMpxKbufqETAlBabCip8PnzN/yzA2uqem4Br+Pqmh0AgirS62gXJy
	 PFX0uxjnCYvxdHvSkTx2HFYPxkA/CLiDrbnR5yvEBer2Ne9aLOy8z5B7lh35O7gHHmXj5
	 OOA8kTg8B5DxM07A3iueWRDj4hp0uJXD3VQmgtSlqDTKvZIl7wAoFxHTTHDWJUs1LoCn4
	 Lf+zMWTUB7pEVvu/8u9z+Rz4kLcj1RvI/Gglv3ODJnKXSAzyZssLWu2klM76infYUR53f
	 tLO6BwBx3nmJia6NglTnGBCZ5p+79Oe48uwZ5t3FVK2/advd8kSZKZh+U2P6tfc9viA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590231;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=bLN0NhbM0nP4MI/JRfwkYiguUPR6Eo6dwOYa3oZlvP0=;
	b=KC8oAHPJaYcuL0I6byg0gkRanuIJO3IpfjsGhO4M6/BIZ+2tBJ0BCtnwZpeQA/RAmYB0
	 Z+Li38wb6gSCqTpGDEHBv8uqKvUh1q1C8Sp/+/2xWR+sriAk1Au904NrSe4Em81IAVxHW
	 y9zdeqm07eqBn41XWsASQg10Umc13m8nsE1cDCtrRggbkH8ked+90sd8ZYDFWD6dQhbgH
	 v7Op83egkyoCpT5tMtZm7UgQtBvywsIcXDRcXFhD2h8AzHBwMYI45nVZqobqMWUnyXPri
	 aQxweVr8wiH5/xr3wv8G8oKcgLOmzPidxaSP5PeSiEAuEYpkbzgW1FPFKW8wcqTeqZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schaufler-ca.com;
	spf=pass smtp.mailfrom=schaufler-ca.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=YECPjUKD;
	arc=none smtp.remote-ip=66.163.188.153
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D1606C0BA
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC0D1606C0BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=YECPjUKD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794590229; bh=bLN0NhbM0nP4MI/JRfwkYiguUPR6Eo6dwOYa3oZlvP0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=YECPjUKDn7BL8mhjx3g9JbH5Ifx6X4Iu3YyxgUaauSJEv9n+xVITFTfvnzzheOVO/yA39/kWNsGDlbbralFN4Kg97/O60NBOcylTU8tPzz9yr0oOItYLEqujgUVKUysRAeRXLsH6nlf06YY1EOsOJzKP3Yu4s8SXjWpPNd1xieI1CsZO7tDnS2dcqosfMVFM2kdMw7MqEJ5AkN1MWuYUIKKe1gQXHVlvFF7ghKsvzhiFIaqczF5ETrCYgcj/hUSflDbwJl78dnnEqEc9QQ+TSJ3k4tGbu+1jLLaVWyutQrbttyzy+tbRCvxokL89Gqf50g41sEvBI0eaHWtPKAY2+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794590229; bh=/U356p/sWXh+RfuShphtS3guHh8LhxtcAwVLtMv/vRj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kEIZVNrjf+vtQiEdO5NKIE45kUdMY5ZzV+SMoa3hJYvP/dXlH4EFBpHkBLHDgnEtMjBc2s8uzgm+WpoZKusayS1/ibcxWde9bFh0CkQBv/Z/iVrmm7ciF7IpftCSpwQb4vojE2Es4HL/+/+Mv8aFCLtWIFJyahFovTL4EgAwrH9gMA9eBRD9H1oxMxkWCfwL5SWYGKj+LWPTm0eTDcF1VHtxKrP34SgKyPx3M7yqO0KvHXXrG6TrQlF0lXq+oNjmW5+pr3QEOC3YsaD219jYSK5NIXnulbFpnKvEEaCQCLq0HHyKdL3imKr81dBUsVjFoO+yiviG+W2Ck2scd7w9kA==
X-YMail-OSG: LZPoUBAVM1k7nNjl2DwBuFuQIBiL7rlkkl89_yhBSP4QxlBsoRZP3wmD3Zhwc8Q
 wo2R_bhfbi4d0.mTEyEVr.oxoA7CtgQ3TxaRRgdAjWoTfC2EnOzCLAQmtu33PsJbpnrl4FHPHjNZ
 KFDKsirfWNLESJfZLpsrCOQlT7i46sbtwd_Y.txQcNSKISXks76C.G0CKbxsq_Pna5WsnKMhhDqa
 NGTwllbK6.dI7Q3luYe16BYXzba9H1u1HFGG4Ong7jKCXgjOhru0KWvgPu_qhJidGGxu.YlQ9YWG
 sbIkRDcyXZsmdXPtaHhBrCDEy.jfsVHIsKY.p6XyoeBNR8GzTBDg0cz9375SvRKplYXiY2QanTlS
 bWazY95McE03x9l2tjuzqCPci9ntwQQ_PhYhNruW.63H60IUPaf5G.MTPsNzAmBzaZjFMFDc40Sr
 gpJx1nYe4MgkhIMC311iyz6KLbZ.z0gi7o43hsmusmX4S1LrfJ_smp7Vq8_qL368ZjUVoRnrwd7A
 QX4KWbo9eqsRSHUXiP09kyyuwCPaTvNaX_NEP.naOAuOMB7Kfv5pGiOJwbyTdt8wmyuP881YqXLb
 6aOiR2xWAJv7qMzA3bqIvYn.NBvREysGd7paDBEA6btXkYUZKGPp6D8saR9qhixxi3bEF0DkCZ4A
 oojr5avZaqU3C9zuT.e0wX58bWVwSUHbYaV4hxyVbj8xWG2RQ3rmlv_wnM5y_8DI.8b41au4K4Dk
 EjdlwUuWxvgKg0vjTGkCXXia_3QTKPQa8qVTcdKxvFuUbY0hx6r3IanP_WKBqxVTgqgkLGX20GTt
 Ldhqf.eNoFtgL8gsL087a27SxJdbDd0wMf_2Kp0iOvXk1ql0nMlIvAeTGYxGFLn4Wplf2n2jOrji
 hrr492Ite6kS5E2YPDz41DDGcvgtJT2oRlCKe9axj9T08kNnSIj3q9b1k.WKbfR5AtUhT05BDce2
 U8KL.zlMgzPjlfGTUnJdJ76717nks3ovt.Ms7JUgejc1hDcwN52Gdad8WCB57H22arWnsFJtFcL.
 oPCWVPfOjZknQlryPxWGaHvFU_24R3N6qz7lP7LV28ai7liauMUVnUYHSAr6nXCcQYfKsWZ5Q1Ul
 h6ZD9lG8LyffT1O5OV_mhZZDj0c11wnS_fBgzPjipA38TXz5Sj.xKWWcigRfnwsiczjrvZV_mjzI
 9zHQblUHbzRTr.vH5O9qBB5AcMqhj9E_XIwoMbvwgy2frNr6UlB.Sxs2Q49n0xyh8CSKO1emFe.T
 ZTCYT68nkkElFOOS6wDvxEsUUkYXRIHr1ZniqLFH3sewu.4pWoi75jcEzmD89T7zCxWWpzZUe.Hf
 sc0Gj2TzQQXH8C6JuzsRvHevQKzeWJYZjr5V6H30UG0Xc3Wf05VrVs3yDVnH45vFknaHQJOQdCBv
 zjG53HGXjx_zdzqKA8ENG9mtE5bwYUkdtmdcNkFIcJt0jToaShDjv2vHJoc69spt2L46pGxthQns
 EvTPK4ditz08gMeUW571RSHR5ozc0EPi8kqUmPG6qDy15UQ1YXQdWvc7uI53Ia8CmJliwU9yBe29
 R.ysvQ8hd2wMQRGrCzk_f55Po7g253cLj0xLxVRN0QS2kUgFd9yX4RqtNrqYEcvfhb_rCSrtu660
 qUAnjTFKLBvh3G9_Bs2iV15FEkGxmMmctw7ev7H_L_.BTYP6q2AmykMscX9J_IbsmgeRDHXhNBn1
 LYof_7wcCjkumewX1HWkXPPUflhLO9zpE.oK2KSkqM8rTX5caYDe9hB8dXqnIoVvIs7TKkn3vKRt
 hDPjcqaimXHyFXCJwegm0bo2pG2ye8e5kfPejwM71M9JKaUAkKq2JG9Rjp94BN76sFVuGJUr4prT
 qNaZSFsMPu5kbFj_HKC6QGNOBjH8nCqkbqNR9aUh6KZlhw9DgcNFKnprYObNvkKkf3roB.K3zBSU
 fLCg87HbWiqbpzhfLEaOycNJrpbDYDuKk0B4zrAqhJGPjFjdKiAn33zFk9lJtusPneN0bquw6e1L
 cl8Svz4bCsoGOqtrZub_ATDMdBBmi1k0q5XNADI64Ic7NJIYJdo8MXueTFOMJCW.hcs2YMQohnWM
 vv3jrF4R0HX0ByoPIMbi.T13SNlZRF3EOh5b6WFYn3b1FV9qF4.fDI.GeyR3ND0hMwtEpS1tUVWu
 YidaJ0lnFLG08ZK_UEUluIqEZHz04zTjXUOgi8bfqMaZkygWz1sXW5ss15hIFPbDXP1u4kT0GzM4
 YJfrlVMRq9kIdRAk1ewEsWLZkblbzIqqnn0F9XXV0CHVp1Wxkuwfodtal8aD97lglGrC9DAdWQo4
 5g5wuwroWARceoavyve2LSmpgG1mZ1_QMCCwX6SOb9g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a240b445-a4c7-4f80-baa4-5e99d725e61d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 13 Nov 2026 17:17:09 +0000
Received: by hermes--production-gq1-fd7994565-f4fpg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d0766b84d50f5d3bff78aca77c06b51;
          Fri, 13 Nov 2026 17:17:04 +0000 (UTC)
Message-ID: <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
Date: Fri, 13 Nov 2026 09:17:01 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Simon Horman <horms@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 stable@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.27017 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/6/2026 1:40 PM, Jann Horn wrote:
> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
> socket, and tries to remove CIPSO options from the middle by moving all
> subsequent options.
> That's not allowed - ip_options_rcu can be read locklessly and must always
> be consistent. For example, ip_options_undo() reads trusted offsets and
> length values from the options buffer.
> Fix it by doing the modification in a copy.
>
> The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> propagate memory allocation failures.
>
> Triggering this bug requires that the system is configured to use CIPSO.
> (Setting up CIPSO requires privileges in init_user_ns.)
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Sorry for the delay. I have tested the Smack part, and see no issues.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
> I've sent a separate mail with a reproducer to Paul Moore.
> ---
>  include/net/cipso_ipv4.h     | 11 ++++++-----
>  include/net/netlabel.h       | 11 ++++++-----
>  net/ipv4/cipso_ipv4.c        | 16 +++++++++++++---
>  net/netlabel/netlabel_kapi.c | 24 ++++++++++--------------
>  security/selinux/netlabel.c  |  5 +++--
>  security/smack/smack_lsm.c   | 14 +++++++++-----
>  6 files changed, 47 insertions(+), 34 deletions(-)
>
> diff --git a/include/net/cipso_ipv4.h b/include/net/cipso_ipv4.h
> index d6780d7903f4..b41672221797 100644
> --- a/include/net/cipso_ipv4.h
> +++ b/include/net/cipso_ipv4.h
> @@ -185,12 +185,12 @@ int cipso_v4_sock_setattr(struct sock *sk,
>  			  const struct cipso_v4_doi *doi_def,
>  			  const struct netlbl_lsm_secattr *secattr,
>  			  bool sk_locked);
> -void cipso_v4_sock_delattr(struct sock *sk);
> +int cipso_v4_sock_delattr(struct sock *sk);
>  int cipso_v4_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr);
>  int cipso_v4_req_setattr(struct request_sock *req,
>  			 const struct cipso_v4_doi *doi_def,
>  			 const struct netlbl_lsm_secattr *secattr);
> -void cipso_v4_req_delattr(struct request_sock *req);
> +int cipso_v4_req_delattr(struct request_sock *req);
>  int cipso_v4_skbuff_setattr(struct sk_buff *skb,
>  			    const struct cipso_v4_doi *doi_def,
>  			    const struct netlbl_lsm_secattr *secattr);
> @@ -221,8 +221,9 @@ static inline int cipso_v4_sock_setattr(struct sock *sk,
>  	return -ENOSYS;
>  }
>  
> -static inline void cipso_v4_sock_delattr(struct sock *sk)
> +static inline int cipso_v4_sock_delattr(struct sock *sk)
>  {
> +	return 0;
>  }
>  
>  static inline int cipso_v4_sock_getattr(struct sock *sk,
> @@ -238,9 +239,9 @@ static inline int cipso_v4_req_setattr(struct request_sock *req,
>  	return -ENOSYS;
>  }
>  
> -static inline void cipso_v4_req_delattr(struct request_sock *req)
> +static inline int cipso_v4_req_delattr(struct request_sock *req)
>  {
> -	return;
> +	return 0;
>  }
>  
>  static inline int cipso_v4_skbuff_setattr(struct sk_buff *skb,
> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index 02914b1df38b..f896b9d52ed1 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -477,7 +477,7 @@ int netlbl_sock_setattr(struct sock *sk,
>  			u16 family,
>  			const struct netlbl_lsm_secattr *secattr,
>  			bool sk_locked);
> -void netlbl_sock_delattr(struct sock *sk);
> +int netlbl_sock_delattr(struct sock *sk);
>  int netlbl_sock_getattr(struct sock *sk,
>  			struct netlbl_lsm_secattr *secattr);
>  int netlbl_conn_setattr(struct sock *sk,
> @@ -485,7 +485,7 @@ int netlbl_conn_setattr(struct sock *sk,
>  			const struct netlbl_lsm_secattr *secattr);
>  int netlbl_req_setattr(struct request_sock *req,
>  		       const struct netlbl_lsm_secattr *secattr);
> -void netlbl_req_delattr(struct request_sock *req);
> +int netlbl_req_delattr(struct request_sock *req);
>  int netlbl_skbuff_setattr(struct sk_buff *skb,
>  			  u16 family,
>  			  const struct netlbl_lsm_secattr *secattr);
> @@ -626,8 +626,9 @@ static inline int netlbl_sock_setattr(struct sock *sk,
>  {
>  	return -ENOSYS;
>  }
> -static inline void netlbl_sock_delattr(struct sock *sk)
> +static inline int netlbl_sock_delattr(struct sock *sk)
>  {
> +	return 0;
>  }
>  static inline int netlbl_sock_getattr(struct sock *sk,
>  				      struct netlbl_lsm_secattr *secattr)
> @@ -645,9 +646,9 @@ static inline int netlbl_req_setattr(struct request_sock *req,
>  {
>  	return -ENOSYS;
>  }
> -static inline void netlbl_req_delattr(struct request_sock *req)
> +static inline int netlbl_req_delattr(struct request_sock *req)
>  {
> -	return;
> +	return 0;
>  }
>  static inline int netlbl_skbuff_setattr(struct sk_buff *skb,
>  				      u16 family,
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index e65a3f29d2ca..ee0c72fbc877 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2004,11 +2004,16 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  	if (!opt || opt->opt.cipso == 0)
>  		return 0;
>  	if (opt->opt.srr || opt->opt.rr || opt->opt.ts || opt->opt.router_alert) {
> +		struct ip_options_rcu *old_opt = opt;
>  		u8 cipso_len;
>  		u8 cipso_off;
>  		unsigned char *cipso_ptr;
>  		int optlen_new;
>  
> +		/* ip_options_rcu must not be modified in place, use a copy */
> +		opt = kmemdup(opt, sizeof(*opt) + opt->opt.optlen, GFP_ATOMIC);
> +		if (!opt)
> +			return -ENOMEM;
>  		cipso_off = opt->opt.cipso - sizeof(struct iphdr);
>  		cipso_ptr = &opt->opt.__data[cipso_off];
>  		cipso_len = cipso_ptr[1];
> @@ -2036,6 +2041,8 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  
>  		memset(&opt->opt.__data[optlen_new], IPOPT_END,
>  		       opt->opt.optlen - optlen_new);
> +		rcu_assign_pointer(*opt_ptr, opt);
> +		kfree_rcu(old_opt, rcu);
>  	} else {
>  		/* only the cipso option was present on the socket so we can
>  		 * remove the entire option struct */
> @@ -2055,7 +2062,7 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>   * Removes the CIPSO option from a socket, if present.
>   *
>   */
> -void cipso_v4_sock_delattr(struct sock *sk)
> +int cipso_v4_sock_delattr(struct sock *sk)
>  {
>  	struct inet_sock *sk_inet;
>  	int hdr_delta;
> @@ -2068,6 +2075,7 @@ void cipso_v4_sock_delattr(struct sock *sk)
>  		sk_conn->icsk_ext_hdr_len -= hdr_delta;
>  		sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
>  	}
> +	return (hdr_delta < 0) ? hdr_delta : 0;
>  }
>  
>  /**
> @@ -2078,9 +2086,11 @@ void cipso_v4_sock_delattr(struct sock *sk)
>   * Removes the CIPSO option from a request socket, if present.
>   *
>   */
> -void cipso_v4_req_delattr(struct request_sock *req)
> +int cipso_v4_req_delattr(struct request_sock *req)
>  {
> -	cipso_v4_delopt(&inet_rsk(req)->ireq_opt);
> +	int hdr_delta = cipso_v4_delopt(&inet_rsk(req)->ireq_opt);
> +
> +	return (hdr_delta < 0) ? hdr_delta : 0;
>  }
>  
>  /**
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 3583fa63dd01..c0eddb6afef3 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1045,18 +1045,18 @@ int netlbl_sock_setattr(struct sock *sk,
>   * ensuring that @sk is locked.
>   *
>   */
> -void netlbl_sock_delattr(struct sock *sk)
> +int netlbl_sock_delattr(struct sock *sk)
>  {
>  	switch (sk->sk_family) {
>  	case AF_INET:
> -		cipso_v4_sock_delattr(sk);
> -		break;
> +		return cipso_v4_sock_delattr(sk);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	case AF_INET6:
>  		calipso_sock_delattr(sk);
>  		break;
>  #endif /* IPv6 */
>  	}
> +	return 0;
>  }
>  
>  /**
> @@ -1156,8 +1156,7 @@ int netlbl_conn_setattr(struct sock *sk,
>  		case NETLBL_NLTYPE_UNLABELED:
>  			/* just delete the protocols we support for right now
>  			 * but we could remove other protocols if needed */
> -			netlbl_sock_delattr(sk);
> -			ret_val = 0;
> +			ret_val = netlbl_sock_delattr(sk);
>  			break;
>  		default:
>  			ret_val = -ENOENT;
> @@ -1185,8 +1184,7 @@ int netlbl_conn_setattr(struct sock *sk,
>  		case NETLBL_NLTYPE_UNLABELED:
>  			/* just delete the protocols we support for right now
>  			 * but we could remove other protocols if needed */
> -			netlbl_sock_delattr(sk);
> -			ret_val = 0;
> +			ret_val = netlbl_sock_delattr(sk);
>  			break;
>  		default:
>  			ret_val = -ENOENT;
> @@ -1234,8 +1232,7 @@ int netlbl_req_setattr(struct request_sock *req,
>  						       entry->cipso, secattr);
>  			break;
>  		case NETLBL_NLTYPE_UNLABELED:
> -			netlbl_req_delattr(req);
> -			ret_val = 0;
> +			ret_val = netlbl_req_delattr(req);
>  			break;
>  		default:
>  			ret_val = -ENOENT;
> @@ -1255,8 +1252,7 @@ int netlbl_req_setattr(struct request_sock *req,
>  						      entry->calipso, secattr);
>  			break;
>  		case NETLBL_NLTYPE_UNLABELED:
> -			netlbl_req_delattr(req);
> -			ret_val = 0;
> +			ret_val = netlbl_req_delattr(req);
>  			break;
>  		default:
>  			ret_val = -ENOENT;
> @@ -1280,18 +1276,18 @@ int netlbl_req_setattr(struct request_sock *req,
>  * Remove all the NetLabel labeling from @req.
>  *
>  */
> -void netlbl_req_delattr(struct request_sock *req)
> +int netlbl_req_delattr(struct request_sock *req)
>  {
>  	switch (req->rsk_ops->family) {
>  	case AF_INET:
> -		cipso_v4_req_delattr(req);
> -		break;
> +		return cipso_v4_req_delattr(req);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	case AF_INET6:
>  		calipso_req_delattr(req);
>  		break;
>  #endif /* IPv6 */
>  	}
> +	return 0;
>  }
>  
>  /**
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index d51dfe892312..24b11d1891d8 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -557,9 +557,10 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
>  	 * is set to AF_UNSPEC, if that is what is happening we want to reset
>  	 * the socket */
>  	if (addr->sa_family == AF_UNSPEC) {
> -		netlbl_sock_delattr(sk);
> +		rc = netlbl_sock_delattr(sk);
> +		if (rc)
> +			return rc;
>  		sksec->nlbl_state = NLBL_REQSKB;
> -		rc = 0;
>  		return rc;
>  	}
>  	secattr = selinux_netlbl_sock_genattr(sk);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 28a8e12603ce..3a4a33568297 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2656,22 +2656,26 @@ static int smack_netlbl_add(struct sock *sk)
>   *
>   * Remove the outbound smack value from a socket
>   */
> -static void smack_netlbl_delete(struct sock *sk)
> +static int smack_netlbl_delete(struct sock *sk)
>  {
>  	struct socket_smack *ssp = smack_sock(sk);
> +	int rc;
>  
>  	/*
>  	 * Take the label off the socket if one is set.
>  	 */
>  	if (ssp->smk_state != SMK_NETLBL_LABELED)
> -		return;
> +		return 0;
>  
>  	local_bh_disable();
>  	bh_lock_sock_nested(sk);
> -	netlbl_sock_delattr(sk);
> +	rc = netlbl_sock_delattr(sk);
>  	bh_unlock_sock(sk);
>  	local_bh_enable();
> +	if (rc)
> +		return rc;
>  	ssp->smk_state = SMK_NETLBL_UNLABELED;
> +	return 0;
>  }
>  
>  /**
> @@ -2711,7 +2715,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
>  		 * Clear the socket netlabel if it's set.
>  		 */
>  		if (!rc)
> -			smack_netlbl_delete(sk);
> +			rc = smack_netlbl_delete(sk);
>  	}
>  	rcu_read_unlock();
>  
> @@ -4548,7 +4552,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
>  	if (hskp == NULL)
>  		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
>  	else
> -		netlbl_req_delattr(req);
> +		rc = netlbl_req_delattr(req);
>  
>  	return rc;
>  }
>
> ---
> base-commit: a91337fb5e8e0127c8b5be87be9f3027f95b48bc
> change-id: 20261106-cipso-rcuopts-e26ffa45b392
>
> Best regards,
> --  
> Jann Horn <jannh@google.com>
>
