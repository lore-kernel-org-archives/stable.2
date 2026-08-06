Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A953D3CFF
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042538; cv=pass; b=e5dwxifunGWZ73eGx2VfUFs+z2Gdx9xCSKZSSgNhWySOoDvC8cFut4eIYaGDgPpaML7PjhwKiHFY1hWCQN5VOr11LynZ2JbQ2d4aLFc6UzvPv/ywtwE3debHsGUotz71/E/9xgN+ABESR8ggj31b3gB6Fy3f4my2nPY1NKtR8yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042538; c=relaxed/simple;
	bh=5/IpOcNfmkuawMpnVdJEufRTFoWhR7T+4g1VX6604+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTh1mYpqAhQa81vIBkQwV/Uyh0a77gxKj0u7t+vfpfumLxI88vVNICZve9fnP2k+gdimw99YiMFTpnDsXIzuJUk6HpbdTir1uuetdEaGCD34cAGjC/HjZDjJFZaD+mdow3SrwXWgat+jb8QAQw6+4ylZz+OYFuj9UPCvWjIw8pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfwP0xR1; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfwP0xR1"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8201447e8cdso42511107b3.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786042529; cv=none;
        d=google.com; s=arc-20260327;
        b=seRpVpDrPG252+6AsCOoUvWtZodsvJJu7xcAoYddX8YktAu5SQCwNaUMtKdQv+oc1i
         IUn+QEbvifFs1kK9F2YbgIWsjow9887zYjfRe0jleQyBivjHq7I5Gq6e8CeE4IUZosL3
         iibsBcaBlPTLZn8dpGCazuhHSjhM6voa57nNQ8lZABlK4uxWR7QJxXnydU9scytBDXJK
         wEfEL5tacYtu6+4KyJCWyES7KlXcte1XiXc8C11e6Vqc2r8hR9J18RdDGAVoWWoddWl+
         ACeSATajterDct9GRLcQL1NZS4ffjDtKLTwv4wr70Ojj+nwtgtfDpTpFJS4AWlQiV6MV
         /miQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ijEOuZ0B1zQLX/0acdYB4Yr9U2fgKW1o7JeKO4NunY=;
        fh=gtZlT0ajtQTmHmpLniT2q5JgGsbdstmBVwd9FwW6o2c=;
        b=IFGVHcvOSUvmr/u47I1AKPeO8EgPY+hmceYaXK8EL7J9w/t5MC0kXYExafuykHd3GF
         htj+s/5nnbEbGCg27HJrGfEFaDr+l2QsPykos62FAEVFHz0JRQqqu0IJLSPe6EEkwsdK
         xQ3yVk6Zcg7YJNHhZjEucWE0RscoUjv5mhH4GvqqWIn6CNvzOErHww5LwRZbvb/pY5e3
         GLaOzZ1N5t5WCOJqWWK/AK1XiEKxbGXCyjCyMc4drAMSfExsXxoRjqkPmYfnK8DzEY8Z
         +PRY69i01vQQNHc1Sjjml1aCU0Nf4lyHhSih2HnLdctofoPSczLl6HE5AUleAUU+0aaE
         GTqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786042529; x=1786647329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ijEOuZ0B1zQLX/0acdYB4Yr9U2fgKW1o7JeKO4NunY=;
        b=kfwP0xR1LYNJeWY9kcse54Qyr1WyZTSP4gf9rry24rOZ8HS00Jnu7Hd/ebi3Nkzdcp
         esniTVDGNdpE86o4RO2uhii+urBHsVj7msfevEbRJZgoFevshtOCNOzSvtWtHn9amrxi
         Rbi59rISahU8HqSTm1R57pwhuxdlgPrF3sqKOIwpNof6t1gg9Uq7+qLknnVs2AJWWGgg
         p3ILUQ7ucVbIuDmJwjIsrWlxRizr7ERkvik8zFzDsQ/fpKqkvMZP5/vxOe334ZDkXPi/
         S+NIhvsEH+LHWAFAb4tTYjzDHVoE2H1dVVXOSpd0olcGRu1KjMZl5PkkprPfAKL5jJom
         iWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042529; x=1786647329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ijEOuZ0B1zQLX/0acdYB4Yr9U2fgKW1o7JeKO4NunY=;
        b=lRXENSsDD3qQGOIbr032NlYnpbBIxmYQU/VNIvf61c00i8ittU/6k8XELr9LTdlzve
         q4SC83lAgMTRlq3TZk5uz7aQ3C44w1njDdQu0zFskdX1inS2c9tDR10BVYTLQoPD2Wyr
         kupc3ilVSU5wFlmduIr5eQbY5/npmGPz2hlVZKEoAVKHsYk/HYpIYXgvZjDxM1ceonv6
         haVFM4w7k6rJdnBjVBdqcUaytduBAAJO9FOp4xoeHjabdmGZ2FdVtj9kEvGeqdF2GDXW
         X+fIhaJ4pIuiUF7x5c44YRnKu9DJW97KK0/gRLxYlU0qAA0Md8EFHUKu1y43ru6/e7UA
         b7/A==
X-Forwarded-Encrypted: i=1; AHgh+RoshMAuwLVkPO9+Ahw9XEPueZ32bt3sZBsLA1dUCRH0rsla5T6Vr4oYbyDkP5f16hdYnbiVDwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0HH8B3L8iEh0EoZtFSuBlnM9GeOj1XIlz8kGKW8NogD/Dks5
	XTjEF3qe9JpySywAS7zbrgZOFcRk6aXkHBn6aXW6JHeqLTSCmcsfF4Pj2XFS6nxYAdS4CjSUmV5
	yEOO6pMPK+bcFj0v/lIg56vgZvRn1az8=
X-Gm-Gg: AR+sD13zldi7MqBaQshOpLsrxjmgcwf8Dw8FIpPVzLNTXxjtRv43ay7B36OUvRGqd99
	OjMcyrq2oMbjioKW9vuHuoDBzUC6ImnY0rpInH7Ao4VEd4IqbN2sYxJ9mv4siO79snuhXdvZJLY
	LAsLlMKIR5O1WjTwizedyMrTmIGbh1q2kXis9Xh2VnMfX5mzind2mGDJOicJet1Xx7kpe1eUeO4
	nqcZ1KKbveY7itpzfn73IB2ISOQeNl7QNY12f1qwc+y2oLGmLsD6ZTfbH/Mp4DYrR/xdSWIlavo
	axKYpqIad5HlfeRMnYWzkBlDpaHhyI/y63651XN9GkBiIY4zD0j7+KUpxsCszSdx+gBRccL6wc/
	pHBqQ+MAQ5zSqAVxWB6NP/hT7nMX+dQSk/8SoXQRpW8U=
X-Received: by 2002:a05:690c:45ca:b0:814:585f:73c8 with SMTP id
 00721157ae682-8201ba5dfffmr106233897b3.0.1786042528662; Thu, 06 Aug 2026
 11:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806174001.267127-1-ali@iusegentoo.com>
In-Reply-To: <20260806174001.267127-1-ali@iusegentoo.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Aug 2026 14:55:17 -0400
X-Gm-Features: AUfX_mw527F3Dh7_Uv8aGPmNBmy8iIRhKkdh0MDHMQK3cVSfqHgcuRI15FqDxxI
Message-ID: <CABBYNZ+e_zyDYSGn2uRZUPR-6gn10ft6FUhk=+bG9u_XscwWfA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

On Thu, Aug 6, 2026 at 1:40=E2=80=AFPM Ali Ahmet Memis <ali@iusegentoo.com>=
 wrote:
>
> mgmt_hci_cmd_sync() checks that the message length agrees with params_len
> but puts no upper bound on it. params_len is __le16 while the parameter
> length in the HCI command header is a u8:
>
>         struct hci_command_hdr {
>                 __le16  opcode;
>                 __u8    plen;
>         } __packed;
>
> hci_cmd_sync_alloc() assigns one to the other:
>
>         hdr->plen =3D plen;
>
>         if (plen)
>                 skb_put_data(skb, param, plen);
>
> so a params_len of 256 leaves plen at 0 while all 256 bytes are still
> appended. The frame handed to the driver then declares no parameters and
> carries 256 of them. On a length framed transport such as H:4 the
> controller takes the trailing bytes as the start of the next packet.
>
> The mgmt socket MTU is HCI_MAX_FRAME_SIZE, so params_len can reach about
> 1KB this way. Commit 03f1700b9b4d ("Bluetooth: MGMT: reject malformed
> HCI_CMD_SYNC commands") only made params_len agree with the message
> length, a value that fits the message but not the header field is still
> accepted.
>
> Reject params_len that does not fit the header field.
>
> Fixes: 827af4787e74 ("Bluetooth: MGMT: Add initial implementation of MGMT=
_OP_HCI_CMD_SYNC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
> Checked on a vhci controller, with the emulated controller printing what
> it receives on the transport.
>
> Before:
>
>   sending HCI_CMD_SYNC with params_len=3D256
>   controller saw: read()=3D260 bytes, hdr.plen=3D0, params carried=3D256
>   first params bytes: aa aa aa, last: 5a
>   HCI_CMD_SYNC: opcode 0x005b status 0x00
>
> After:
>
>   sending HCI_CMD_SYNC with params_len=3D4
>   controller saw: read()=3D8 bytes, hdr.plen=3D4, params carried=3D4
>   valid: opcode 0x005b status 0x00
>   sending HCI_CMD_SYNC with params_len=3D256
>   HCI_CMD_SYNC: opcode 0x005b cmd status 0x0d
>
> One thing I left alone: hci_cmd_sync_alloc() performs the same truncation
> for every caller, so a guard there would cover more than this one entry
> point. All in kernel callers I looked at pass a fixed sizeof(), except
> msft_add_monitor_sync() which computes total_size from the pattern list a
> user supplies through MGMT_OP_ADD_ADV_PATTERNS_MONITOR. That one looks
> like it can exceed 255 as well, but it needs a controller with MSFT
> extension support and I have not verified it, so I am not claiming it
> here. Happy to send a follow up for either if you want it.
>
>  net/bluetooth/mgmt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 167d75e34526..c16b0b80c193 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2668,6 +2668,14 @@ static int mgmt_hci_cmd_sync(struct sock *sk, stru=
ct hci_dev *hdev,
>                 return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC=
,
>                                        MGMT_STATUS_INVALID_PARAMS);
>
> +       /* The HCI command header carries the parameter length in a u8, a
> +        * larger value would be truncated there while the parameters are
> +        * still appended to the frame in full.
> +        */
> +       if (le16_to_cpu(cp->params_len) > U8_MAX)
> +               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC=
,
> +                                      MGMT_STATUS_INVALID_PARAMS);
> +

Hmm, the command should really use u8 rather than le16 here, but that
is probably too late to change it.

>         hci_dev_lock(hdev);
>         cmd =3D mgmt_pending_new(sk, MGMT_OP_HCI_CMD_SYNC, hdev, data, le=
n);
>         if (!cmd)
>
> base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
