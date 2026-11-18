Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967494;
	b=1KZDAlGwOP/Df3oZYJFh8qrbVOfJkl1E6VVSzsemcy6GAuYT+Yk/de3HimHMo6E6nt/O
	 DYhu2FWO0YXDMdr19xeOhBk/O19ulWGaYfcCjOCVctJJvtpUGF15zvkfEWKbb5cOy7lED
	 onYMg5KzDu9xDBS8tynmjJ/fGq4jJaG5STpwaGihptbPd+5pzsxu3aLbG4VFrNb9ljNK9
	 U+tUTLjg1kToUwHihUXUOoGrjBZ079X1pLCJZUgtWjawiC1bpB9iW5LZSGDBEFoZbCqTl
	 soFO7g1JX5T+0KstXqvv2B2iW48Wylp90CN0TcJx+1QE0iXM6UG8xnLLBt75+rL536A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967494;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7idpOK0uLj0IeEH4I8ykLNX0Cq8hKyMbZ0eKNeKvegk=;
	b=tzwrfX3nKg2IZtmfO9OtoWeroCqaALNstO1IqOIZvxVtjap3gjeDLZVjULylpv+7ocwb
	 nq/gdYhq0Feyjal1F8/hGWTViIWnoBn0QqSN7e94T+lWCA6BnSnfGXTu7GTNGDgC1JTxb
	 krVvJPLLn90FHT0cGTO2A7oW61/+Lcm+Na5egYNNkOcmBtZLHB+skCCfY6nTyo5l8vmZX
	 DkuCMIUJTICQBnbJ2o6gs6BEJXPCQXQStDe2EnkN+G6MgFfhvB0Q1IQIfNfRi5DOH5ck0
	 CWxHV9y2vdQDJyyfdc2SD4NV+CvBcFDcXOUpCZEU7Y6vRokKu4Uw9FJiU5Hs6gubomg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTFcnP8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7D606A31C;
	Wed, 18 Nov 2026 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTFcnP8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216141F000C4;
	Wed, 18 Nov 2026 02:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794967494;
	bh=7idpOK0uLj0IeEH4I8ykLNX0Cq8hKyMbZ0eKNeKvegk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nTFcnP8MbRS5d4pxU3UnKAsWRer/12OXCwy/dor8M6yoTHEA6ZXvCCEieve4SwUmx
	 9Q7uoAMK4V62w5DhJfeKkPM4tynL4KQp4+4lhQVRQ2EhHxDbcAD6K+0fQ3Ck24TkCH
	 DZkLfUFrugvmrJbypvhvABHyS9vW6J5ZNQfyO18Lriqrksd3UxTTE+Hv3gWlP4YUGR
	 A+OSdRId3pCz94FLWEo4tuJ05im+g/nFdgHylmnR7NAUp6I5P++IlPiNYVaEz0kZW7
	 J6lipFXnG1ggEWg8XE+MMXF7VVuJGAZDorzd7ebeKRKO9Fs4j5RH1U1ZJP/QR6ywxl
	 nB1s8h5XxRrdQ==
Subject:
 Re: [PATCH net] mac802154: remove redundant security_enabled assignment
From: netdev-bot+sashiko@kernel.org
To: petrvaganoff@gmail.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 phoebe.buckheister@itwm.fraunhofer.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
Date: Wed, 18 Nov 2026 02:04:52 +0000
Message-ID: <179496749259.3136.6007006994790888929@kernel.org>
In-Reply-To: <20261116065235.27348-1-petrvaganoff@gmail.com>
References: <20261116065235.27348-1-petrvaganoff@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix relies on an invariant that does not hold.
- [Low] The subject 'mac802154: remove redundant security_enabled
  assignment' presents a bug fix as a cleanup.

--

mac802154: remove redundant security_enabled assignment

The commit removes the assignment hdr.fc.security_enabled = cb->secen from
ieee802154_header_create(). After that, mac802154_set_header_security() is
the only place that sets the security bit. This targets a KMSAN uninit-value
report in ieee802154_hdr_push_sechdr(), triggered by a stale cb->secen after
WPAN_SECURITY_ON followed by WPAN_SECURITY_DEFAULT.

> mac802154: remove redundant security_enabled assignment

[Severity: Low]
This isn't a bug, but is "redundant" the right word for this line?

Removing it changes the transmitted frame. When
mac802154_set_header_security() takes this early return, the removed line
was the only thing setting fc.security_enabled:

	if (!params.enabled ||
	    (cb->secen_override && !cb->secen) ||
	    !params.out_level)
		return 0;

This is a fix tagged for stable. Would a subject like "mac802154: fix
uninit-value in ieee802154_header_create()" be more accurate?

> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index f437b8daa00d0..7b7332805ecce 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -368,7 +368,6 @@ static int ieee802154_header_create(struct sk_buff *skb,
>  
>  	memset(&hdr.fc, 0, sizeof(hdr.fc));
>  	hdr.fc.type = cb->type;
> -	hdr.fc.security_enabled = cb->secen;

[Severity: High]
Does this fully close the uninitialized hdr.sec read in
ieee802154_hdr_push_sechdr()?

The commit message relies on mac802154_set_header_security() keeping the
invariant that security_enabled = 1 implies hdr->sec is initialized. That
function only writes some of the fields:

net/mac802154/iface.c:mac802154_set_header_security() {
    ...
	hdr->fc.security_enabled = 1;
	hdr->sec.level = level;
	hdr->sec.key_id_mode = params.out_key.mode;
	if (params.out_key.mode == IEEE802154_SCF_KEY_SHORT_INDEX)
		hdr->sec.short_src = params.out_key.short_source;
	else if (params.out_key.mode == IEEE802154_SCF_KEY_HW_INDEX)
		hdr->sec.extended_src = params.out_key.extended_source;
	hdr->sec.key_id = params.out_key.id;
    ...
}

It never writes sec.frame_counter or the reserved bits that share a byte
with level and key_id_mode. In ieee802154_header_create(), hdr is on the
stack and only hdr.fc is cleared by the memset above.
mac802154_header_create() has the same pattern.

So on the normal llsec TX path (llsec enabled, out_level != 0),
ieee802154_hdr_push_sechdr() still copies stack memory into the skb:

	memcpy(buf, hdr, 1);
	memcpy(buf + 1, &hdr->frame_counter, 4);

frame_counter is overwritten only later, in mac802154_llsec_encrypt(). By
then, packet taps in dev_queue_xmit_nit() have already seen the header, as
the TODO comment in net/mac802154/tx.c notes:

dgram_sendmsg()
  wpan_dev_hard_header()
    ieee802154_header_create()
      mac802154_set_header_security()
      ieee802154_hdr_push()
        ieee802154_hdr_push_sechdr()
  dev_queue_xmit()
    dev_queue_xmit_nit()
    ieee802154_subif_start_xmit()
      mac802154_llsec_encrypt()

If encryption fails with -ENOKEY or -EOVERFLOW, mac802154_llsec_encrypt()
returns before it pushes the header again. The 4 uninitialized
frame_counter bytes then stay in the data that AF_PACKET taps copy to
userspace.

The reserved bits survive the memcpy(hdr, buf, 1) in
ieee802154_hdr_get_sechdr(). mac802154_llsec_encrypt() then pushes them
again, so they also go out over the air and into the CCM AAD.

Should hdr (or at least hdr.sec) be zero-initialized in both
ieee802154_header_create() and mac802154_header_create()? Another option
is to memset hdr->sec in mac802154_set_header_security() before filling it.

>  	hdr.fc.ack_request = cb->ackreq;
>  	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116065235.27348-1-petrvaganoff%40gmail.com
