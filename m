Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE89390981
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659963; cv=none; b=U5QJebE8dwUg0wpIsyALzjRHLsFHAzWGlZ3G8z6zWOFdc3jZv34cPuqUrgcV/x4uxCD1U3lCjL87t8mMb9t5FL7xxWK5KIrFcKEdJCGxntx4TkuMaEjC9fKz0hdt1Y96o8yPz7HsOTzKQTiBIR4gCBedDW6g5ljfuOIf/TzBnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659963; c=relaxed/simple;
	bh=qBzJRPSIwfkZH2tMi/hPWOxxUFCnhOzk5IKDuNq0wkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJLJJT1e2LwKbZwepYK7lonACkTMcZAzlykm6fh1yjomQ/9PbJxek6hosBPqOODuvQsaJSmcDF5fuhMvzJ+Aa3bB9XxVBsRG8nxb5FDrYaugb61uxfRs/0ePPjsU9j/V4e/6q6F2W0tPp5kG9kUzP4iPgakP6/U0v+w/e5GWAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IbvAdpek; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IbvAdpek"
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-9673385b1efso811063241.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785659957; x=1786264757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+VjNc7Cj5tMz12o6jEVSiidd0PWIOvTtdYHTchu4Pc=;
        b=ohyJhYPTHz20C5e0ZXQ68tYGCN686dbXJZl6jqntntqsBPhj2llxGPr3KqgDnXiHTy
         V2W/VBKmKnINYi6VNjKzokk5dPI452NiufViAreqF2qggWN4gQpWDngSOgwmixAs1RfN
         4ONDkdk2bwV3qqY3mBUHWgdazEe3exB7aCYdDReiC2lRlijv5a91TTiDCkZgdvAL/HhX
         U06Qkw/B5yX+KxIPfzqWEmkpti9DGivemvpT3R8TTU2xeWRAJHtRz217Z/YwGbFyLpCu
         VsFoVkFE2C8CmWGxZOTmPfJ/iwuvynVXUr/zigcKwc5psWMT6dN0Y3FPe0xoEjxi4j8p
         pnWQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHTWQAFesddirJSUMXaWQ8ihZSpXUl9DmdlO7cE5yhKiaI4M76dvw3YgKnbwPzWR7enLZqNT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnIN0DzJxoZ3naHlyZruHMwx4VUgeKoZfnCjHijYwP6ZuDXiW
	mDjP0h7/q5fVL9qXClUmnoNZhf0Wsvli9R1SeUubp6Ub/4tuX8LNLPK6Y+HlFFuGjNrSWIo9ZRi
	T4jD5IzJ6YLV5xzBAp3MeV80xsiGnR6DoiOTXUJVruYur8YS7JldJAB+sOrPJD3RF2XkJT3JMWo
	1iuf71EnJOPozfChVcjl66BvvEfK4yXJtNkuTlkCGgjvlKT/7L1Jjr+Y7LXyZskw1k6qvQrZCcb
	bu9SiUlG53V/1FNtA==
X-Gm-Gg: AR+sD12NGXCUTKjRrT1vKCz1TeLCMcXGBSOpi0s1qEgR2Db6PfKcMH/38t54bykssZZ
	Ux2h9oascjtn5cihDVQmDdFQ8KAMOlALk6lZgh6zqhpuqB1bfQOY1Jww24LAsOOj7rmuBI85kgk
	88NgQFbu+6NhmUbmUjdolPn26IUSxZkmvJUGGufOqsLZTULAWkVQZPK5l7E/SfsmgqVS/ZOUT9X
	vQqZaHNPwTBkfCXzXtfFrx35YPa+eHAF2mghtTDjKUMftmb/vNIk5eY7gxVvghuuX3v9pd6Yq5c
	qRnIQUw4JE8r9Hd662J59QH6CkFNVUpl1/KvXTfofdUZACjFZOroSmRi+1t5673zX4FJVbpFLfj
	IV1YPqxMDmlBGPq+42pvV3ZRcZHqDkCNNz5bLz8vZwQw9bU0Y6SzHSdSFXw0y68nwNBsnLAtWNR
	U2O0nDwG9ncOcibJZ2hKDy3PvxK6hlH9vQoToikYk=
X-Received: by 2002:a05:6102:8082:b0:631:28c1:154c with SMTP id ada2fe7eead31-75b2396580bmr3777469137.9.1785659956551;
        Sun, 02 Aug 2026 01:39:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-759c9c49161sm518033137.26.2026.08.02.01.39.15
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2026 01:39:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8e9489f62bfso26303526d6.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785659955; x=1786264755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+VjNc7Cj5tMz12o6jEVSiidd0PWIOvTtdYHTchu4Pc=;
        b=IbvAdpek3Jo0xD0dF7y6swqc875XcsMNT6C5F0Rn8KlqW1ualijI6k02MZq7edf4WO
         B/+0uk8mPS2b8pXmUHIUCmNwFYUmJCmf1ai1NnKLiOgsjGzIjT+odFK8kRn9rHzNiEWj
         KaLK4IQ6OH5jk2aBhF7jXPYITKnUkf5hJG5qA=
X-Forwarded-Encrypted: i=1; AHgh+RqcmMEI8fECJPwdWe8UaUhMK6EUyChvVxKQ9540oWWYCqMVl7RkTUYIgv3xn1KZeDgGPtcg6I0=@vger.kernel.org
X-Received: by 2002:a05:6214:5b06:b0:8f6:2588:778a with SMTP id 6a1803df08f44-90849558b55mr131975816d6.4.1785659954742;
        Sun, 02 Aug 2026 01:39:14 -0700 (PDT)
X-Received: by 2002:a05:6214:5b06:b0:8f6:2588:778a with SMTP id 6a1803df08f44-90849558b55mr131975596d6.4.1785659954328;
        Sun, 02 Aug 2026 01:39:14 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435def8fsm49457956d6.38.2026.08.02.01.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 01:39:12 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH wireless] wifi: brcmfmac: validate msgbuf flowring IDs before use
Date: Sun,  2 Aug 2026 10:39:00 +0200
Message-ID: <20260802083905.3819981-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723055618.550834-1-pengcan@kylinos.cn>
References: <20260723055618.550834-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Thu, 23 Jul 2026 13:56:17 +0800, Can Peng <pengcan@kylinos.cn> wrote:
> Firmware messages carry flow_ring_id values which brcmfmac converts
> to an internal flowid by subtracting
> BRCMF_H2D_MSGRING_FLOWRING_IDSTART. The resulting value is used as
> a bit index in txstatus_done_map and as an array index into
> msgbuf->flowrings and the flowring state.
>
> Validate the firmware supplied flow_ring_id before using it. This
> prevents flow_ring_id values below BRCMF_H2D_MSGRING_FLOWRING_IDSTART
> from underflowing and rejects values outside msgbuf->max_flowrings.
>
> In the tx status path, complete the packet with an error after
> removing a valid packet id so the skb is not leaked when the flow
> ring id is invalid.
>
> Fixes: 9a1bb60250d2 ("brcmfmac: Adding msgbuf protocol.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  | 46 +++++++++++++++++++---
>  1 file changed, 40 insertions(+), 6 deletions(-)

One nit: there is a double blank line between brcmf_msgbuf_get_flowid()
and brcmf_msgbuf_dequeue_work() in the resulting code. This comes from
the pre-existing double blank line that was between
brcmf_msgbuf_remove_flowring() and brcmf_msgbuf_dequeue_work() -- worth
cleaning up to a single blank line.

Minor enough that I will take care of it while applying if you do not
send a v2.

To be applied to wireless tree.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
