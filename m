Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAE549380
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790114263; cv=pass; b=VYaI48+QmS9XzTfOrlDtUOYp3IKuE9ltqLMtx9xNRCFdXirTBihRRfwpfPP7A8zS6kfj0AIBV41Tn5MjSMIVRSqxHz8kf2JRjc86RZngKU8nfsigkA3PKb8Fs04KAmjaHvBPUkZ4ZbpCcifct87epAsDtYGZyuXemiek07jYuTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790114263; c=relaxed/simple;
	bh=CO3As2TmPZjHhrml1U6HFpp8ONG/W6yW1foBj5kICTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM+1xRQFjEvbUkFVoTjxF0CQGUVI6loU4DXE43N3uuJyZVSmmmlEKXgAEiLWzXXffezwVB2GNg3A0mqlJO6FyXO8Zheb24BQXuaBM2F/o5sZLJCNLgzR32l1OU+Yszlmpy3h7BlCoKFT6V7WnNVy9WHkk3c6NSKTnBbp04sD5jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us5TBGfs; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us5TBGfs"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so211996a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790114252; cv=none;
        d=google.com; s=arc-20260327;
        b=a/faYYO5a9FbpT+/gJEwJBHEpVYRq+B7f5elJZv4Ud8a+xFppqaY91u8YHet5fjIOn
         NtXJdm3xSycoVsL+DySdUKXVSgOiz2wB6649sGJ4YFg9DunQIollOviToNikyXJvIZ+A
         1FgmtH14p13V0AcG6Tu/FcSp+kJUmCk0nsoi+kGU0gd04qVoUPJ0vtkgstHfPFgojzRd
         G2liX29J8RGHMnG5J159cA7vWZ7DQuRuL2t4dxxaZ61uRAvmMd8br43j/6btO/omIQ8Y
         NwH41vxmYCkapDu5tIdcmzuhHkiIDeRKSnNDUTjEpRGXvROX1Jz7oQzkRo6rkIjhRZFP
         3a5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2BfXLyRqjaoskONnpzQx5gIvbEJzshUx98T89RqkqU4=;
        fh=tFyfoUezasWyLr3R2h46BeXE3WA/dueNHP1w/cJ3np8=;
        b=ZjVcd5WmQrZN3VPJSG+ihed8rW91qTYIcv+AK1Kt2o/2eIUxzmBLSnMgYUoic+FXIi
         ScBsB+CC3xrJ7s7N3e33d8N4WKOBn1dJqzPwyRArD3+DCRWgkDaf2a2lkR/5wdX3JWrx
         eHMIZmDT8ZvpMZEAwf/4zFqlAdR0+mLCxuFunCnmfrU6AhOX8U0rL/YuGN+4kdmziZQO
         Csy5IKkVLqg5BNL7bpcxGEBpnA+EDRY9H/SVzY1h3eJzbsVtLJhH0i3Fs8fCNiow/S+L
         78Ep8gm6D/Efas0EV4KgGcl9R5KcHNtrU/B58g492zt/hcvAi6zOPnS6+T7mfomhkTTT
         ugyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790114252; x=1790719052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2BfXLyRqjaoskONnpzQx5gIvbEJzshUx98T89RqkqU4=;
        b=Us5TBGfs3qeUoDvHlwFmC+tSk+tOUiIYUmkdxk1M782cBUKM4Qf0A7UehHiYOfZJ5v
         0Kz9TqdS3FH7E2gtjnYuhgiIv6FoIR14bvBhNZSSm6kVEbJeIHgWR9ENHw2p3OFUy+ld
         8lrM/oIl8ubdqz3YLpsJMvr7bFyr+XbJ56HfEXMyxgIHLuOSZ60QJvPqt6RA/+z0+9DO
         49Nqgnib+bSy9rw0ALx2Q33lDChp0cFdhmy7HKN6xZOxAgpDCVZJwj/amL2cD3NbmNhN
         BFm8ilOSy2mZsmMcGxvASomAh05FBM3D+WTZW+s3vs07/1Gjcz40EeBpG7HIM7iN1F0L
         1qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790114252; x=1790719052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2BfXLyRqjaoskONnpzQx5gIvbEJzshUx98T89RqkqU4=;
        b=CP5vBCVh9VLPADz1i0t57qR7MPySEMrIarUWGM+xmZxXBj+FjZsc48LGe1xyLUmeOz
         rE3eMQ+KB7vha637vlYLIscSuc4F9bIYTFrOSVKaDtHWIaa0krBXDjOiAWvcMkHLSn0H
         ucn6B+5nlVHFiOIENdKD7SOSXFgSFSQHOltLGdcn83+SVKRn3aoJDdVNBBk9sJZp0KjI
         HpAArOHLT0EfIQojDjtIaksOdx0oiqFRBgPjZCFC32tjR/urWdGzqdjpC7KjdHsNIj+K
         vxRmllvrGfAl+9ZOg3ZpYDGCyquIe1pHFCPDUmn7uuMsImJu15tJ1Ov0gk7yz+OYyrr5
         uJZA==
X-Forwarded-Encrypted: i=1; AKwUvBzKwv45AMLb1sNVialXe8jxuH1dqLnsEylPBoEF7W+o6cpv4pIlhLHcs0XXghM/jW0Hz7dCSHU=@vger.kernel.org
X-Gm-Message-State: AFuF++nwWlULY72fBOEkH/tJJQYf7W05R/j1BN0xf3KQn6/M2Ud0PsKh
	wM97kQGxrNMdO/Lxp3wqAMSMhGoW/wKBZ2v/GzKuEQ6Yu0kS9tcilnhAiKP61nwOBvqtq4QXfNd
	dxKZAsDgAAuMtZ5mjM0DgdUtFwJ904kw=
X-Gm-Gg: AYBFou03Tb3AkncaB+nXrsI3+tcORUAcHGXk37MshA2732joRUozBQlsaOfrkbhqzL7
	ogZsQph5F/NqX2mM8WHrbRzVEN9smrEqz0b7QMS/czGiJ/ml/4fKGKd34LlOXDa0KWARK3ay8oH
	z96eKOOhCRxOhbYG2jVVsXpCN8oaflT2fmRAkn+uA5d0Pg3jsVQDNmcF21z21kk/9AzyJYzudWl
	w2wDGswiRBCK2Ympe4KSEUfdZyYW/sq5V/yo7WTOVVHWxoEck4LNJtYUiIrzJO3mR3NJPiIeqIg
	604pc8Wbxn/1eRVLLHUlmxVlozjscU5LaC0w62gaNYhgP7IGrwNHTYxEMvtp4PkPw7/rI2H637B
	TGT67oqQNS/ggu4KNXA0vgFMtmN1xhLN309PlPGMcubdOgJ+O8ppPuIwY28WnpgZ0zw==
X-Received: by 2002:a05:6a21:ed0e:b0:3dd:85aa:4524 with SMTP id
 adf61e73a8af0-3ddf7f621c9mr671555637.31.1790114251607; Tue, 22 Sep 2026
 14:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_eQjfg_-HLT3zJ5Bt5LWbUTx_+fLG5ggLPNY1Ah+sF9GA@mail.gmail.com>
 <20260921093707.1432184-1-ljp1205831794@gmail.com>
In-Reply-To: <20260921093707.1432184-1-ljp1205831794@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Sep 2026 17:57:19 -0400
X-Gm-Features: AcwNN1U7cgG6CZuztU84c0xhghDR4KjaSxl8F5SVHRVMSVuORbENN7O2ZFigJc4
Message-ID: <CADvbK_ftzE++ETSSjwUL8qHAzjy6eZY6uU0oMJyfBABC1CdFKg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: discard the rest of the packet on a
 stale-cookie error
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, imv4bel@gmail.com, 
	Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 5:37=E2=80=AFAM Aohan Mei <ljp1205831794@gmail.com>=
 wrote:
>
> Hi Xin,
>
> Thanks a lot for the review and the suggestion.  Implemented in v2:
> SCTP_CMD_DISCARD_PACKET queued at the end of the stale-cookie retry.
>
> Verified with the reproducer: the kprobe trace now shows the ERROR
> chunk still removing the transport (sctp_assoc_rm_peer/
> sctp_transport_free fire as before) but no further chunk of the packet
> being processed, and asoc->peer.last_data_from keeps the redirection
> done by sctp_assoc_rm_peer().  The KASAN use-after-free is gone and
> the association completes the retry handshake normally.
>
> This also takes care of the other same-packet sinks the sashiko review
> pointed out (sctp_cmd_setup_t2() and the sctp_make_*() reply chunks
> copying chunk->transport into association-lifetime state): the
> remaining chunks are now dropped before they can run, in line with
> what sctp_inq_push() does for chunks whose transport was removed
> before processing.
>
> Regarding the cookie-echo restart path the review mentioned
> (sctp_assoc_update() removing the arrival transport mid-packet, with a
> bundled [COOKIE ECHO][SHUTDOWN] reaching SCTP_CMD_SETUP_T2): discarding
> the packet does not look like an option there, as bundling DATA with
> COOKIE-ECHO is a legitimate fast path.  I can look into clearing the
> in-progress chunk's transport on removal, or a loop-level check, as a
> follow-up - please let me know if you'd rather have it handled here.
>
Thanks for checking the AI comments from the last version.

First, you need to check if it's possible to remove a transport that is
the same as chunk->transport in sctp_assoc_update(). As far as I know,
the chunk->transport should always be included in the new asoc.

> On the bitfield concern: v2 no longer reads transport->dead at all.
> The race described (sctp_icmp_frag_needed() in softirq doing a
> non-atomic read-modify-write of pmtu_pending racing dead =3D 1) would
> also defeat the existing transport->dead check in sctp_inq_push() from
> 03a9d10ecf71, so it might be worth moving that flag into its own word
> separately.
>
Sounds good to me.

But move pmtu_pending instead, as I think it's the only one bit that might
get updated without holding the sock lock.

Also, split this __u32 field to two __u16 fields without changing the size
of struct sctp_transport.

> As for the reproducer: it is a single static binary that plays both
> roles over a TUN device - the victim side is a plain SCTP client
> socket, while the peer side answers the INIT-ACK advertising a primary
> and a non-primary address plus FWD-TSN support, injects the bundled
> [ERROR(Stale Cookie)][DATA] from the non-primary address while the
> association is COOKIE-ECHOED, completes the retry handshake, and sends
> an FWD-TSN one second later to consume the dangling pointer.  It was
> verified on tlinux 6.6.119 and on mainline v7.2-rc6-343, where it
> still fires with 03a9d10ecf71f applied and is clean with this patch on
> top.
>
> Since it is a ready-to-run trigger for the bug, I'd prefer not to post
> it to the public list - would it be OK if I send it to you and Marcelo
> off-list instead?  Happy to share it in whatever way you prefer.
>
Sure, sending to the maintainers is okay to me.

Thanks.
