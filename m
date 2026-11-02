Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652825;
	b=JA1FYN0Q6W0lw0VGRIxwDkiuSgYm57AbShTdkr6yVyFxmDYi/cPWRajm63eHK5WXgqly
	 PTaTUbK6+Qk1PE/JEKIQkSb541k1uXWY+EZoMj5bb6kj3LE0LR+ZwqQFtG13eaBHsdrGa
	 h/Pgnh5RdDThRGCNQ5oMwiyyMV3THOi/X7NX8M9STdZ3u62P0dABa3/AdSVkAdyixMmsq
	 iKrjn2/m//EMkQagwRV+T5OdD9PpE+M7iA7pnRd4qrEvGOXoKqB9LzchSNJQ/LZ9pvhip
	 ItHzQgBibY2PBNgk6cf7qrwd3v3S6Ep8ILWHIeMpex+x9/d5DYeVqfB+tom/LoIIOiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652825;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Ur3NviQueuDZp/pCVj/27L9uAAV8y8uuySZxoytmQug=;
	b=VsiF64sgMSa/KDkD04PIJN0HzytX06zrhe6yGJL6RIMaCQ2vN4i7fa77S9VA8T5nLDPw
	 cFmZUPLxvjsO3dhwB49lEPdqx5AaZc3LC4n5TKH7LBTJIynWWVOT/kOnk6B3NxK8v6BVQ
	 dSRTt3GKq05Mgd98w3+Y/zDGkzmJv/vtH8u6hb9T3X/bVfvb4Z3gKMccXQvFvzDhAhX1p
	 eFE5CR0763J2LXZTUuNlbZgS0Bs2chuxZFJX7gzUcuMJTgl8ZqlP2AnrBIRxazmzQep/U
	 Y1dSFzDdCzCBi9lp3UWDXWPtSbWnN9b9+ZsqfvJf/ztC43cMXDq+l2puscsuoasg3GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YawTYY8D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A4606A324;
	Mon,  2 Nov 2026 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YawTYY8D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93BD1F00A17;
	Mon,  2 Nov 2026 20:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652825;
	bh=Ur3NviQueuDZp/pCVj/27L9uAAV8y8uuySZxoytmQug=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YawTYY8D5b3yE1kRxar+UxdPKKLK7m2Qlq2UkleFubA5YRIVyrbF3vaqOhSO1rVrY
	 YmsE2hYf7jBbo8z9M+zJyurDskyyAhMTQIMsQQrPFFdFKOKYV0OMexg0GMcJ5oCFuY
	 3wDB2mtzXXgvYDj+NbzYOoA7QyqHJ7JBE0+DHpKmWBufGY7ohTRFIwr7c8T621NmUf
	 gbNoIpOUveaN9TQMwdj54OeDdzLNq2Moy58f/3LEmHEjcvEacS4bMPDtArP6o7SnNf
	 3ASkCrGzZ7mJC1thuM62j+IJ102VKjk7ZFTaS66m4oWu5wvGT4dwEmMY2ujZ3o6bYQ
	 0m5FmmN5DTZOQ==
Content-Type: multipart/mixed; boundary="===============0323927478722233340=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a6b2025486dd16d90b6f292f136f07d3ffa73cb194a07ef5687e583275594b48@mail.kernel.org>
In-Reply-To: <20261102202922.2515317-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261102202922.2515317-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH] bpf: netns: require CAP_NET_ADMIN for link targets
From: bot+bpf-ci@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,Jeremy.Jean@oss.cyber.gouv.fr,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 20:53:44 +0000 (UTC)

--===============0323927478722233340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: netns: require CAP_NET_ADMIN for link targets

TL;DR:
- Flow dissector BPF_PROG_ATTACH may still bypass the new netns capability
  check, unverified
- Check may wrongly reject CAP_SYS_ADMIN-only and sk_lookup users; the commit
  message doesn't say so

> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 81006a242618..0ca29c20ba85 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c

[ ... ]

> @@ -488,6 +489,10 @@ int netns_bpf_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
>  	net = get_net_ns_by_fd(attr->link_create.target_fd);
>  	if (IS_ERR(net))
>  		return PTR_ERR(net);
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
> +		err = -EPERM;
> +		goto out_put_net;
> +	}
>
>  	net_link = kzalloc_obj(*net_link, GFP_USER);
>  	if (!net_link) {

Does this close the token-versus-netns hole for BPF_PROG_TYPE_FLOW_DISSECTOR?

Flow dissector programs can be attached through both BPF_LINK_CREATE and
BPF_PROG_ATTACH, and the BPF_PROG_ATTACH path does not go through this
function:

bpf_prog_attach()
  netns_bpf_prog_attach()
    net = current->nsproxy->net_ns;
    ...

bpf_prog_attach_check_attach_type() has no FLOW_DISSECTOR case, and
netns_bpf_prog_attach() and netns_bpf_prog_detach() have no ns_capable()
check on net->user_ns.

A task that is root in a userns, and so passes bpf_token_capable(token,
CAP_NET_ADMIN) at BPF_PROG_LOAD time through a delegated token, but is still
a member of a netns owned by a different userns (for example init_net after
unshare -U), could load a flow dissector program with the token and call
BPF_PROG_ATTACH(BPF_FLOW_DISSECTOR).  That appears to succeed without
CAP_NET_ADMIN over that netns, which is the outcome the commit message says
this patch prevents:

> a token can be used to attach a BPF program to a netns it does not
> control.

This is pre-existing code rather than something this patch breaks, but given
the Fixes: and Cc: stable framing, should the userns check live in a shared
helper that netns_bpf_prog_attach() and netns_bpf_prog_detach() also use, or
should the changelog state that limitation?  (SK_LOOKUP is link-only and is
covered by this check.)

Also, should this check mirror bpf_ns_capable()?

The new check is a bare ns_capable(net->user_ns, CAP_NET_ADMIN), but the
token code treats CAP_SYS_ADMIN as satisfying a CAP_NET_ADMIN requirement:

kernel/bpf/token.c:bpf_ns_capable() {
	return ns_capable(ns, cap) || (cap != CAP_SYS_ADMIN && ns_capable(ns, CAP_SYS_ADMIN));
}

and other attach-time checks use that convention, for example in
bpf_prog_attach_check_attach_type():

	if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
		return -EPERM;

With the patch, a caller that has CAP_SYS_ADMIN but not CAP_NET_ADMIN can
still BPF_PROG_LOAD a flow dissector program, but BPF_LINK_CREATE now fails
with -EPERM, while BPF_PROG_ATTACH of a flow dissector still works for the
same caller.  The same applies to a CAP_BPF-only caller loading an sk_lookup
program, since BPF_PROG_TYPE_SK_LOOKUP is not in is_net_admin_prog_type().

The commit message does not mention this user-visible narrowing, and the
patch is tagged Cc: stable.  If the change for CAP_BPF-only sk_lookup users
is intended, could the commit message say so?  For the CAP_SYS_ADMIN case,
would falling back to CAP_SYS_ADMIN in net->user_ns keep the permission
model consistent with load time?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41521741043
--===============0323927478722233340==--
