Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6153E3167
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370400; cv=pass; b=jMRnHcCc0BVFZZLbXtd8/vu3I7eBtuZY5h8egc6wKKZiyBSk4nae43wz1ENfWRPbsxiO6q3+WEGPwtYDRYwayX3gNTWrlfdaXnhKiv20RInT6EZunHOzq/Qw1QbuF7qUiCO+O8HLCMP/yZSHxtbKD+seBQ+dQdmq1gu6CZgZ06k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370400; c=relaxed/simple;
	bh=216somtno/5OJTGWhEpg7rNFOlcyGSpXRqRobuTtA68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECrPmSUAo0lZ/XzZ6/BIcwP/bTI3TK7tmIKnNEy4WTTdfR9cZ2rstWyR+iIDUZIlkxcYrEznU4VdRUdLgcO9hbqWisD/z0uM4e7tcIk7+Zy3LbDFDVkf1vV/bI4yklznIV5pqYM/WsLgf6DNOhkBOvTHrIKUhvdl3OsHFUB/3n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WIpzMfKS; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WIpzMfKS"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcede83so2453847b3a.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 06:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370398; cv=none;
        d=google.com; s=arc-20260327;
        b=iVh0Nuw4UW1+sej0Q8MwlvDT7WvBMBK1/Kprg3aviUx9hP+W6jIkRYjdsNx8sRzxrn
         N4xhNoP6oVPdC7HinzurCyk4Tm6jcuabL8CfB4WoIQXMkAK1+DrZQFPgbIWDJOdj+yMR
         pTiCN+6U4+z9iGYsh1QWCadvsHE6JyNw2yqTYnq2RYiow07xEcOfvbZMTmSvcGPVRp/g
         E+2a2V5tz/9pZkUTy0O91n/1DQgm2/IsC4Vmz2jy6Yv0k6hVJK544et1Cum4QdEs50eJ
         2fwU4c2m54B3ilBgStV4yZY2TsKrUxAOn45+demoW0nfGwE6vm8Zs4CJzOWmS+I0CYIe
         1ryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
        fh=/kyY4JwSlFfdPtGp7V84lQgwbjL+UvHBTJPQNsOlrv8=;
        b=fkFlTQlPv982Em8tmIOjo7nJJzxi8COrpR2VQ21eIzRCr0uDLCX/TTOXecGDA6+stA
         shi0BBZYAl5Y7U48XGZgq6JAj3tFpwk+/RTwoFYlAriXLH2hMg9+8vTqB6xXliPriYRg
         1E1noYcR/aAXW8TUmdyKgQDEMs/dxwmGdiGszVvQhLOCE7g8t6X8R062EG0TAY5lTbL6
         2PeXkF1V6TJYCzSZq5iKnFc29aw9PDoXf10GkDst/Tki4TODLhm2J6h6MJoaNtaLL9TA
         LRM5X4xOsfI4q6HHM7lU9/EHreNwcVSnERMN7Yha2UepqjbYI6jEBO1jVIOb9+FIRi5h
         ep+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786370398; x=1786975198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
        b=WIpzMfKS41Bd2KwJvSnf2Kul1IzSHVyXDZxgAwtObaTuMn3n27wMtJaoo5GSotIk3x
         3kptEWPGePpo/cPlF0fzOF7S/2myVQ+2QNZYE2chaXgcFaYXXDczU5FBKFKOMCNFgXdN
         b1Q4o4rSgQyfTn5HRXBAfrB/8RDIp7ldl0PmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370398; x=1786975198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46MZNjNXhKCE5DS6Jx+nsMAYwugJX53AXQsLnuBwmDo=;
        b=qKwDgHIvnmpDK9tcM773znvACypRHLVQySLh9P9slTJMFrGb2W/4Om7qzOQDRAYDMq
         1CFwYmE99jN/gm1xUNtMQ0r9RwFYQnU8PI7OokjT1mO2kHsafn3HXrenA/R/hZwYd7A/
         CVhCZDZXgRsBuIA5V+tR3Jq/NdL29Tgcxije9RHSGT1BCpXy3fU+4IrKy4CetHi2IRMR
         ssdGnZR134fhuKV8qoZnHn4Ua2pV9vZkwd4mNvuB6SDtr6YYcQ8A/JMPv2U69U8AwclD
         umpDYTSGQWgdC+TRCeIbpJ/8AzI8nvcPa6hPGwVYceRjfok8KGibUdldvySBVvpuFQUt
         sTZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIYMRUAVaZy/v5pGr5RzVDXnXLfmUrFjc5pK3kkEjoRTDyghc7fyZUOnzZ2cGkNA+5RCkIMPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRIVjnaw3jHnmZRM/EfCB+5VKpPR3H/eH4EzyxHSZsunACQ/w
	3zhGtCJnzKkzpGmjVg1A/BcmiK5CZKkrRg4srJMQWrMToa4NGLbB/65oCmj/RZ1qdS03RXooYTB
	UOdr2BN4nEJdZHjQ4djuqywd44YzJ/TBRyfvj25Vq1OU5KIsevgQPzQ==
X-Gm-Gg: AR+sD11Q3WdYrbsOZ/NS0/FncS25kUDdGj9uhYr3LRju93vZTr8SFHiVSrTjIYv6BiI
	VgkNjtuzOZibQwSDGNLiLVJ9v9XmQh7nvUCrZA/CpBLafjw6LGsW055XkEfckxqsLjN4wyDbabx
	BQ01LsxTgN8S4uVGFhGswKZAuCIEojtAEFIcNH5buu/j5iySpLagvYFTytGI8wseIcZz2CwrGmy
	X5638oiTr5cjM24KNswdkLMPoPJ280uERJxaANpS7dHKwXlmY+muwyyZKw333uBVHpYr7/nQe5O
	G/0Od2CebtOLnfhnjfwoRIMIPISAL7es38Pbj2pNwm3/Ew==
X-Received: by 2002:a05:6a00:3310:b0:848:5540:2377 with SMTP id
 d2e1a72fcca58-84f5dfbad07mr26834874b3a.17.1786370397896; Mon, 10 Aug 2026
 06:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 10 Aug 2026 09:59:46 -0400
X-Gm-Features: AUfX_mxRG5jLc08nNMpM49kTVM0uIbxQQVBUXgRTCxaHxX5AM-qtREHzLHaaOE4
Message-ID: <CAM0EoM=L4LBAnyxf+NG1D_dY2nre8fKgVxoycXK=sY-9Ruc9+w@mail.gmail.com>
Subject: Re: [PATCH net v1] net/sched: cls_u32: feed u32_replace_hw_knode()
 with correct set of flags
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	anthony.l.nguyen@intel.com, kuba@kernel.org, jiri@resnulli.us, 
	edumazet@google.com, stable@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Marcin Szycik <marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 7, 2026 at 6:23=E2=80=AFAM Jedrzej Jagielski
<jedrzej.jagielski@intel.com> wrote:
>
> Fix u32_change() to pass proper variable to u32_replace_hw_knode().
>
> When trying to offload u32 cmd by adding skip_sw attributes it gets
> ignored and it cannot be correctly processed by HW and tc_cls_u32_offload
> struct which is then passed to driver lacks skip_sw var enabled.
>
> u32_replace_hw_knode is fed with the TCA_ACT_* flags (bits 16+)
> instead of TCA_CLS_* flags (bits 0-4) which actually stores the flags
> parsed by tc, so tc_skip_sw() always returns false. This leads to
> ignoring some of the attibutes which are meant to be configured on filter
> setup.
>
> None of the TCA_ACT_FLAGS_* is actually used within
> u32_replace_hw_knode(), so there is no point in passing them.
>
> Looks like commit 695176bfe5de ("net_sched: refactor TC action init API")
> shadowed the local flags variable which used to be set with
> nla_get_u32(tb[TCA_U32_FLAGS]) with the flags as the new function param
> while not replacing for none of the u32_replace_hw_knode() calls.
>

The sashiko reviews look legit to me. Mainly: your change makes
u32_replace_hw_knode() able to fail for the first time (with the
action flags it always returned 0), which turns three previously-dead
error paths into reachable bugs.
So IMO, this needs a v2.
Suggestions for v2 from the sashiskos (I typically suck at these
summaries, so may miss something):
- Release n->ht_down on the create-path error (e.g. drop the reference
explicitly before kfree(n), or reuse __u32_destroy_key()).
- Consider switching the update path to tc_setup_cb_replace() (as
cls_bpf's cls_bpf_offload_cmd does) so old/new flags and in_hw_count
are accounted for correctly, and the old rule is re-installed on
failure.
- Mention in the commit message that skip_sw add/replace commands that
used to succeed (and were silently skipped by u32_classify()) will now
return -EOPNOTSUPP or -EINVAL when the block/driver cannot offload.

Also seems worth Cc: stable backport.

cheers,
jamal




> Fixes: 695176bfe5de ("net_sched: refactor TC action init API")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  net/sched/cls_u32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 8f30cc82181d..dc6e455e64ec 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -935,7 +935,7 @@ static int u32_change(struct net *net, struct sk_buff=
 *in_skb,
>
>                 u32_bind_filter(tp, new, base, tb);
>
> -               err =3D u32_replace_hw_knode(tp, new, flags, extack);
> +               err =3D u32_replace_hw_knode(tp, new, userflags, extack);
>                 if (err) {
>                         u32_unbind_filter(tp, new, tb);
>
> @@ -1161,7 +1161,7 @@ static int u32_change(struct net *net, struct sk_bu=
ff *in_skb,
>                 struct tc_u_knode __rcu **ins;
>                 struct tc_u_knode *pins;
>
> -               err =3D u32_replace_hw_knode(tp, n, flags, extack);
> +               err =3D u32_replace_hw_knode(tp, n, userflags, extack);
>                 if (err)
>                         goto errunbind;
>
> --
> 2.31.1
>
