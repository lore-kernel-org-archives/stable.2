Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BF481FBE;
	Thu, 10 Sep 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055553; cv=none; b=kg70cFZ8QW+kUGctt7EBqPc+Uyo8eAtmhvXY/gV7td0kRlesfXrC+bvLkFP6cXbk/2FX8MqQXajxqAr4lKyFKl1wms9RiBTNgYIFCgpifLh+ZpzaagNJ3FyEquwz48z5YWDVp0+wpOlBeQSEqLedRxknqMVyXqrX263L77Vcrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055553; c=relaxed/simple;
	bh=pUlSWictvp/eDSu91ES6EO7H5q04wHa+8g5OJOCT5S0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkVjfa4WUULmu/awFpnHYeYsHNS87qa3NfFxyXZXm+28YAcEPu+9vqv0QnAc7zAWHbPiaL+fSJ72hhE0ZaOBZDxletVDgLNwHV2K0LWmeASN435kF9hyQujg3UcfnSchHxhlISBAxKYRD1jF/ElFj5/qeHDzFTGSxtdRwpJ05qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZACdnQCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZACdnQCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDA41F000FF;
	Thu, 10 Sep 2026 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055551;
	bh=ADE8OsHyYORA6yoeRAcFH03eBG7vlWU09tWqM5pgBHs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZACdnQCBNDCzTOpVvqm9H8qu47NWGW992edIRDrIQWMn/uQK/67Pb166d2wPblV1w
	 HT2a7F61eOjHNObfW1Mzp6bygxkhMBEHtdkg5BvZf2j3lCz9UNpSvvppL3DmNU4mKl
	 hN9cHPSIniay+r+6mAYVpLGF58H54G8HVziYZeLbH5ERXHCWRq1NAg/I/bPgFj6xQl
	 am2X6zlB7iUdmX/rCggw7u+H35iWwQNmONwlcje/rxIMO3vtMvXhyALSMy47Tw0HBJ
	 z2GjfKhj1BfXYCYUu+WcdqiMT5NmqUe1qXyqzAgkuhWg4NEFSLohseNNC3vDAaTS54
	 fKK4hsjR/J+Rw==
Subject:
 Re: [PATCH net v2] openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()
From: netdev-bot+sashiko@kernel.org
To: echaudro@redhat.com
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, cpp.code.lv@gmail.com,
 stable@vger.kernel.org
Date: Thu, 10 Sep 2026 15:52:30 +0000
Message-ID: <178905555085.219967.6617611783437228045@kernel.org>
In-Reply-To:
 <1b1582eb07550d71f3cbe210e5cb31eeb8d0ad86.1788876917.git.echaudro@redhat.com>
References:
 <1b1582eb07550d71f3cbe210e5cb31eeb8d0ad86.1788876917.git.echaudro@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

- [Medium] The `case IPPROTO_ESP:` arm of get_ipv6_ext_hdrs()
  (net/openvswitch/flow.c:287-297), whose whitelist this patch changes…

Pre-existing issues:
- [High] In get_ipv6_ext_hdrs() the loop tail unconditionally advances
  the parse offset with `start += ipv6_optlen(hp)`…

--

openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()

This replaces two uses of IPPROTO_FRAGMENT with OFPIEH12_FRAG in the ESP
and AH arms of get_ipv6_ext_hdrs(), where the constant was being used as a
bitmask of already-seen extension headers.  The stated effect is that a
packet with two AH headers now reports OFPIEH12_UNSEQ in addition to
OFPIEH12_UNREP.

A couple of questions on the ESP arm and on the offset arithmetic in the
same loop.

> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 46c1d66aad8c..868d9fdf3afd 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -288,7 +288,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
>  			if (*ext_hdrs & OFPIEH12_ESP)
>  				*ext_hdrs |= OFPIEH12_UNREP;
>  			if ((*ext_hdrs & ~(OFPIEH12_HOP | OFPIEH12_DEST |
> -					   OFPIEH12_ROUTER | IPPROTO_FRAGMENT |
> +					   OFPIEH12_ROUTER | OFPIEH12_FRAG |
>  					   OFPIEH12_AUTH | OFPIEH12_UNREP)) ||
>  			    dest_options_header_count >= 2) {
>  				*ext_hdrs |= OFPIEH12_UNSEQ;

[Severity: Medium]
Can the case IPPROTO_ESP arm ever run?  The switch in get_ipv6_ext_hdrs()
is inside:

	while (ipv6_ext_hdr(next_type)) {

and ipv6_ext_hdr() in net/ipv6/exthdrs_core.c only accepts a fixed set of
next-header values:

	return   (nexthdr == NEXTHDR_HOP)	||
		 (nexthdr == NEXTHDR_ROUTING)	||
		 (nexthdr == NEXTHDR_FRAGMENT)	||
		 (nexthdr == NEXTHDR_AUTH)	||
		 (nexthdr == NEXTHDR_NONE)	||
		 (nexthdr == NEXTHDR_DEST);

NEXTHDR_ESP (50) is not in that list, so the loop exits before the ESP arm
is entered, and *ext_hdrs |= OFPIEH12_ESP at the end of that arm never
executes.  That would also mean OFPIEH12_ESP is never reported in
key->ipv6.exthdrs, and the OFPIEH12_ESP entry in the second-DSTOPTS
whitelist can never be exercised.

If that reading is right, is this part of the commit message accurate?

	This caused incorrect OFPIEH12_UNSEQ verdicts in
	both the ESP and AH arms: the ESP arm failed to whitelist OFPIEH12_FRAG,

Only the AH hunk seems able to change an observable verdict.

Should making the ESP arm reachable be part of this change, for example by
admitting ESP into the walk:

	while (ipv6_ext_hdr(next_type) || next_type == IPPROTO_ESP) {

Note that would also need a separate advance for ESP, since the ESP header
has no ipv6_opt_hdr-style hdrlen field.

> @@ -301,7 +301,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
>  				*ext_hdrs |= OFPIEH12_UNREP;
>  			if ((*ext_hdrs &
>  			     ~(OFPIEH12_HOP | OFPIEH12_DEST | OFPIEH12_ROUTER |
> -			       IPPROTO_FRAGMENT | OFPIEH12_UNREP)) ||
> +			       OFPIEH12_FRAG | OFPIEH12_UNREP)) ||
>  			    dest_options_header_count >= 2) {
>  				*ext_hdrs |= OFPIEH12_UNSEQ;
>  			}

[Severity: High]
This isn't a bug introduced by this patch, it dates back to 28a3f0601727,
but since the AH arm is being touched here: is the offset advance at the
bottom of the same loop in get_ipv6_ext_hdrs() correct for AH and Fragment
headers?

	hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
	if (!hp)
		break;
	next_type = hp->nexthdr;
	start += ipv6_optlen(hp);

ipv6_optlen() is only the right arithmetic for HOPOPTS/DSTOPTS/ROUTING.
>From include/linux/ipv6.h:

	#define ipv6_optlen(p)  (((p)->hdrlen+1) << 3)
	#define ipv6_authlen(p) (((p)->hdrlen+2) << 2)

For an AH with hdrlen=4 the header is 24 bytes, but ipv6_optlen() returns
40, so start lands 16 bytes inside the ICV/payload.  For a Fragment header,
the byte read as hdrlen is the Reserved field, which the sender controls and
receivers are required to ignore; the correct advance is a fixed 8.

The kernel's own chain walker handles both cases explicitly in
ipv6_find_hdr() (net/ipv6/exthdrs_core.c):

			hdrlen = 8;
		} else if (nexthdr == NEXTHDR_AUTH) {
			if (flags && (*flags & IP6_FH_F_AUTH) && (target < 0))
				break;
			hdrlen = ipv6_authlen(hp);
		} else
			hdrlen = ipv6_optlen(hp);

With the current code, any header parsed after an AH header, or after a
Fragment header with a non-zero Reserved byte, has its nexthdr and hdrlen
read from sender-chosen payload bytes, so the OFPIEH12_* bits stored in
key->ipv6.exthdrs and exported as OVS_KEY_ATTR_IPV6_EXTHDRS can be steered
remotely.  Payload bytes that look like a second AH or a HOPOPTS header
would raise OFPIEH12_UNREP/OFPIEH12_UNSEQ, and genuine trailing headers can
be missed.  There is no memory-safety concern here since
skb_header_pointer() is bounds-checked and start advances by at least 8 each
iteration.

The two-AH example given in the commit message still behaves as described,
since next_type comes from the previous header's correctly-read nexthdr
field.  Would it make sense to fix the per-type length handling in a
follow-up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/1b1582eb07550d71f3cbe210e5cb31eeb8d0ad86.1788876917.git.echaudro%40redhat.com
