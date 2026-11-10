Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.187.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327015;
	b=3Si3VcFHln3uHhWmnnaHR5bXOr3VUbmhwZNuIFgv3PQku9QBOF7Xdaxb23fAgygFPb0l
	 nXEuTYdWiDhPFSHQGlsHgmh89roeDt2Hv8AJPRD6Rm/+H9C50d0jfGZPct8S7kk5zCnSE
	 /k9H7vMCPZA6WK6qy95BlpwM2hgFmv41hiaNFm45dNu66GkZR062yMeYfY3OoDkH1heWV
	 rTODaVF43ZVNgegbAa6L/Kkgg9bdLPdPnKi2/aar1ZUCYCUnJVqyV840zdHDiIXZxLcvR
	 hRiik6QPYATZHR7TnNM+cq4prop5wx+LUNvo9TpW3xdtOn6+gkgmnFS0ckguGdiykvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327015;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=oSS4WZMg+AwEc5ixcTpFKAZSZj9r7pV8NkBL0oJRo30=;
	b=jQx7L+3NUl78GUGVfsrYPgo1y31gPoJIe5pm2YyZY8QTSwYjOCHmuOd7XezS+OA6qNCv
	 BC3BJLvIgvGKz+ZhHfmem1iaRySjxMBtNcaCPT8/Lgy7A5KL2pHkfoHcQH8+vfnyw3aMh
	 CZyPZP3Pkkxt0fsuVwR7lF9vO3Y9GZ8GuNHsfoc//H+nCeCTJ98UooL+3q2va2VfpNfoJ
	 JmNxW0Eb6UZSXvlDbiLJHLbPKl4GVVX99bXIu7M+lJxeG2/IdvJN/nOE0BNVMQlzWXWcH
	 WtDHXOYJ0LVkg2JS8GOhG77IxTgwjRYSn/v3t5oKB3CMObppbYzVCLZ99Ehqolbwzfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schaufler-ca.com;
	spf=pass smtp.mailfrom=schaufler-ca.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=SOIAbrMK;
	arc=none smtp.remote-ip=66.163.187.38
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2660A2611
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E2660A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=SOIAbrMK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794327012; bh=oSS4WZMg+AwEc5ixcTpFKAZSZj9r7pV8NkBL0oJRo30=; h=Date:Subject:To:Cc:References:From:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=SOIAbrMKkyGp9OZuVSfVwbYM9OOvjS1Z6dbjEON8MkqvFh7cBUIYE6H18njesc938Fx6wpaHD2mPgVMHwHAOjemsNo/BU15ZjTl3XXsWwpTmnk1m2z8Q+KS3p78jciieuqmcAOL6TXOirB4DaUj03xVyaJ1zE6yqsDwTntjXCy+dR64c4dZRBuQw5WAq6v+i6GkkApSIEhpwDxfKP0KGImcHS0S3qEhd/AG9LMv1s1MAbJY0zuIkkLcL+t1h5etwhDBPritDRNtdL9Stpd5kInqonxgq7hk0zwF6OBTPi4su2+pGskq9ODDH5VBCAv0mIHE/7CuLqOSvnv1p+72LXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794327012; bh=fz6IVq1FZmzxOtAgJnQdgBGR6Xw7uq1FJ5+ksRb7Qh+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XEpzVEVCuCQLdrZQ5HJ8nkH5sV4H5VxQS63NJupp8ng1QwlEYuc8tPqcnoNNWO4J1J8vzYvpQ5h7XRNB8xZaLseFfmq/cMDmTNAbR7k3ks+/ZBNTeEE/wW4tI/7E3Cax+lsKjuGtSn2d7NjE1K/L5Un9N1tn87PMJTc09j+D5s5VOnr6H8gdzQEhkyBsC6kE8edwgDDfqMLXIjpIN5aodmaAvoAsKr9XymxG2EZCpgLWMei7EMIVXkIhGuD31aX5qM1AP5kAfV52dGpoIIldkmgDF0+EsFDd06pP0Om5zj9hGgSVfZ0JgFWWvgsu9EYmpXiNPqyOOgoZ3rH3IgPlqg==
X-YMail-OSG: cuaHXEIVM1nete8BXB2wTMZEHbHJbrSY_B4FQtJo8eHYDAWohJhKopVj5mH12dm
 ikczGhVlf1OuUzIAT.VJ7TOeTdbszNUf096jb536PiJN3R1z3.y5YffoHYlna26jV0gPCFh2yu6f
 AjcbQzHvRkQOiO3OSNv4IXjd8av3vi_8ECLsMZaogZ1sL2fsXtNqZwROwfo_bKudCinoUe8sCO77
 5Vq0xblHhNgzEFGUN6APyeXXjCFvTv656UdqO.qYuh65UNy9bL9FBn8bTJ6uwFmktwNdQmaO1OQ5
 9zMH6h.ekhUIZYVQoQ3jCqb.ci2yJ6LDOnWcWplM4dUICNpIs._EOGzAixP.JXfRP5wj55Fv8poL
 llFKK5LzDlLEjqktrp1NXl_HRmGOWXta1ChCPVb70AIVMHevLn2xFySFI8FSm6J9ed_C4K6b5bB4
 lNLXiTe58IILNbXMiu6v2HCl.ORzB7Idb.Pic6utMA9SkoAot3.UVXavs779c1wD5GN66TnaPHu.
 G4oV_H05QkvLY545wtawrwcpWGmG5cNJr7hmRteqYdAwVvfNbJ7QIEdkiSahRvFyhQh6mYClRGc7
 t2O.FrZ7xY6iuND97uMiOuDZ_3JHkOGbF9u_41TRs1LvmZSWy7Sk_jp5XHeQGVM_eFUSDCwltEN1
 E8jS0diT0Tn0yCs9WQjibMpvorIyi9nFT7Ew3HVYgzr28RQh_dgEyGCv18R9s6lainDYgqhEmwth
 pRQM1zg8OeHoygQyugGP5DiWwBgeiFAMT_HPapobhkJubB8833GeS5TMpaBoSzpPc1mb08EGlvkY
 qQ4lKmDZimyfzUWNtRhGPS7jKhodACji.Ua4hlqSoyfLtvDc9tKAFDuaNkXvbaTrGgBCA4w5SXbi
 RmlC5yKjwIQXw8RgvpNpiZjy7rA7jSddBjbFaDBvDk1TOkE85JWOyjd8DUgiLXXWq_Lwf0vgkpXK
 os8ip1NQrs5r3nhG2BrmfeRwW1OPz1G4.OMJ4_bt23bHDXutQIzIe57azHkLxs4eQTO6UWbwhjv9
 0cbYSIbxnPUbuI8AZ1x_Lv0Bk.Q862ZfaZQvGEZ1sT8YkHvhDJWoZNvDX5eDn4xFuxAJYdDMAqz1
 BoqBDJ.U6aeVafgGlI32WihCTErSxg5UfVmw_T7NTNfOI8zyrML5erky1gjHLoLf1mJvao7KTWjV
 uwf4_Zdb.b0lTsFPsdz7Fy.Rqz_usVZRdcWoDRW0fuszTPP7KUeeFQ34UrPvAyuUEEFmYDrdkkhe
 mK1OvTQZeiDsRmta9vcs8eqRVb1pXE9dwJKySi5JxjP9cgQH9366jAitpuzJPeRpiXv1dXPbrsAS
 t3bW2BVmmm8eFr1iqNZ62yghucOYuNb70AsCFwNcD7RDhYjAQYChJWw3LJ6Yd7QDmqZ8seiTg7EZ
 Ziv9l.Y4QTanKQNGSyJCaFpzdL8431PLacI9jkIJWL3X9Z.5jVLOHbWJX0heT9s92QJNNSPD5zN9
 tmmGj2cvVXJrA3Ksdx4oS_d4IdHTHBwBZqLI9rO9iWFdgIoY2hLJPzCp7rvSkXTvU.SepeyJXkGW
 dPEzzp6cnsnK3lhhtp_IZtjWyloRsC9GFT9ru60_9Ic6ycUyVMCg3Od_GeuqWYnRwd2fMsVAaGtu
 a2r9NRIZWkesDdqkts8QxhLEP85lM11mKVg35n_bb7FyK.ick.cvR3pFz3Zi0uqBT4F8m6T72ucK
 5iENzkyQFq3DSzib9oK3NNYtsizsvWxtwV3PDC5.MzgIelKQcxGcRVET_mniiofKon23foFo7R4E
 M4Jci8cJTwU8w4lep1J3ZkHky2X.5.LP2fSbg1KmN04uZf_0MV4c8PvrwJnptVZAouvYZxg2GDMK
 J9_Kn0AsWCRHtHoqQoiYS9BqYki3z_hVMZDn7OQmYb5qdxDXuz7JjP0ZC.KPQabv3JYo_aCWjfni
 MrIdaklnqNbNOckyQ3JG8SYQm6G6LzfBznnYSdHuE5wXR8Jy3b9VoWPp38np5CR1izxe2hnHHg4K
 WkyZJhRSXwoa2mCqCkFtwiodyW.Axkw0o7BJTkVkEKSEymPina0vvDjLHt5d6_aj9crzlY29fszA
 LFbSnWylOr1u5Xub06_QnDsL1e7QFhEfGB3b_Xq.Su3YCw7ay_Q3A.3Au6uuG89WPIGlxasO8tyb
 p6jFrBeQz6Jjm_0T.mhekG2LazHnQfYLp_3dOlqqpP2VpW0v8KKsHP187CALJ4iRyUp1.vPfrvRS
 b_uoZNj1cyZm5uY8.wuaAFeOqce4w1S6fHe1DEu73qeNIqV7Iq9r5zuJ3rM.vXFdnQzrDNURLPFi
 6vheCKhCy9ziuq41DIt.M_v2PH4O68sUpwD_egIhk
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: eda5be16-cfd8-4b27-abc0-6f93b504213d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Nov 2026 16:10:12 +0000
Received: by hermes--production-gq1-fd7994565-ftb5j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1a702877587429920f6b8339028acdb;
          Tue, 10 Nov 2026 16:10:07 +0000 (UTC)
Message-ID: <3eac0567-4f7e-4d55-a051-44aabf1a4690@schaufler-ca.com>
Date: Tue, 10 Nov 2026 08:10:05 -0800
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
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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

I haven't had the opportunity to test this, but the Smack changes
appear innocuous. I will try them today, weather permitting.

>
> Triggering this bug requires that the system is configured to use CIPSO.
> (Setting up CIPSO requires privileges in init_user_ns.)
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
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
