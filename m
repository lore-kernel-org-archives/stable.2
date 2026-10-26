Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024843;
	b=KIZaJchv1MKnKIogyVwqPhA8sU0o0iRk6MHtCpR3UPyuTb7amaNeeEL6+R++S21s4HFL
	 AIzVFdCkEDpO6wh1IHr6/qLCaZ88FA4tZnDLOPDhIOKPliAd/Cr9AK1hqNzeieVjG7eEc
	 CXOMN6CnzOebxeQAuFV7JG7Bv63YvBVMIN1u5UPQIngQQngs1LZITXVnbVNUXdYXb/LC5
	 zJGd79dC3rnFackp2kbb7RwJ1olNSEtkj5G0SeyqT50rOew43bRyrpyOfDbkmxJkR5T9R
	 XWvdGYIhuhjcBZW2mYlte73cxiwXm1roxmczioYpFYxEdleQt7nMMprsmSKvhMLiMdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
	b=YHh5rK84eVjCvA98ZtMU+ezGRWyK2hBkVy7QUHbpyv/VEo1q1iMmylvpp9s0jqO6tGJ/
	 a0MZzBj/QLgZlwDuY7i6yuRz6MDbqEfnUK5yEaK6O6pVBAcqEC+tdACChMRBoo2tf3C1Z
	 OqUMu9TvfbtwOzAupDHcI5X0/fsvAm8dA0SKrT4LApIYBAzL/08cewosJydXNJCcb69cE
	 6CK0kG73eT4+fYXsJzpCYH6FLTWD/1my+Uvd/zKrL4zZstSaO9kCQ6TZF/YRE01TyPheD
	 xmIZ5j6mUrIPMI8KGAufzzYn8LSSrj1xwzuhccEJ5HaXxqFmItbThlC2zrP0RpIwu0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhlxvgU1;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078D606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D078D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhlxvgU1
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2df921c1d0eso13749785ad.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024842; x=1793629642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
        b=XhlxvgU1GrMaPNJspEjfRmGarJy5LJYRRhTg1Hq/82/Zw43IZLmp1XR/SVpCsCs05U
         BoGs9OSrt8nbSJESb3b6dLlIhykpaBy28HH8+8wK9xG+vb2OSN/fiGslwFxR/GKZEZ8z
         m19YStf2V0YttCwB+h1Ew2WhtANJutgxfoX0HLvXOn6juDf2bZROzyGtjQ4vvRzF+7XO
         pm4XP+AZgP36L+2ig5rDwJ0P1QJdE8Q0aVP36TEb1uirPl3ZKJ1WrDZOhzgckhWRNmIn
         GkkvbnCuyiz50A6qCwqJCiz9XxLWrqnGx7fqHQfrfdSw5/PXSL0VMpNbQxZQedFvav1G
         +gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024842; x=1793629642;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWNIDudccydM955IzkAINXE2ZjY/ipVqw0niCy80XBs=;
        b=wHOSjy5awN7vGEJd8BiLriyZgTKGiI8SWrJyh4RWNSW1Yhm+42y0aAn459vsiNRVpM
         qRNPJyBZIj/dfXPoNn+ja3R9M41n7wpc/QtpNX1noUCe0UZxbRC9k8detyMztR60WIPK
         Sf7lyFK27hDFy9zA+40XmNi9Qigdptf13Uqs3mV3z4M+Tf0Q7RTp5WtDuj9784lU3iDQ
         gzyzr7B3JRvhcxFa6Ejtz7JOADeBa/7gvwxNnr0ACsQ5YiBquvYpESozlTiWM6WEB5OA
         OJg4KbqXC0u1ZWpEfG7/GycspSYhBCQd/fHtJx+Nt15fmZZ64XXWXgZMRBmFXnkE6xph
         V81w==
X-Forwarded-Encrypted: i=1; AKwUvBz1Jywe4my3nEyESF9JvmC3iJWJyNCOCp7fswxNvJIRL67LQQsxenBCxh1Q7nF22bv3rFTJLNk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEMYC1kPhAqo8KntDsvQ9eECOKnZsv3y0H2OarccRxX5zWPWGR
	vZdbeXsRPrkvmhM8lv3YGPCZRSoLjbIaUUX6sftsDz1+vPMxwAsG29PqPMrkifmaolHH6gAs
X-Gm-Gg: AYBFou0OyQH2sen9WmJLBWSyfVjq1mvExntfLMe4CT1Xde8OL0Fl+1AE6BvLB9wtq4r
	TiNn0w7BfKY+dH3BjICTBOSreZmXgs+ksjfp7QMydNMCXMq9p5MtS90AD6NmcBDfOtxo96h9fm3
	LyCh+seayNvpnXxDLS6o5EwqOYHwLpgfZa/gYsu/qrv5gfgXtOBA3PeBU7Sj/5G1Xj5Sa/mQ/+X
	nUwVi3Y1ynYY3WCmaJNqQsOdITWiBk3nW9mySqMcwq6O0KH/6+m5LAE7Z7roO4M2Y0/hCZOs7q/
	GcPIUdF8+4dor9e1JrnMaffvB9zXlhGtj9Xew3ao86oGqqBXfi/WVb0NCAMSnRqWDBpIL4biSAc
	7S/p2yTBJqrFYnIdM8hftd96vgN/VOxViADuIihKkQjRb0gtv1yBndHGD0R5kLtjqM8CyzUmD8h
	HtRRFADk1cp1yvvICLDBH4+Fwj1RXyuKN6wva5lNOX02M1rlRp/hEB5BHqAhaqlayaFmUSm7K0o
	zy3mB7NLw+dTbgFEe6Kea87EA6s4z/2ZoBXRGgPwkkohn8oo+56ZYgZiDnKYD/0uWqGb6aYFzJl
	bSaWCYkTaiKO+Uup
X-Received: by 2002:a17:902:f68d:b0:2e9:a090:dd80 with SMTP id d9443c01a7336-2ea9c69710dmr55298395ad.22.1793024842080;
        Mon, 26 Oct 2026 07:27:22 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2300:286:8580:7ae4:15b1:705])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b121725sm17638495ad.14.2026.10.26.07.27.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 07:27:20 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
Date: Mon, 26 Oct 2026 22:27:05 +0800
Message-Id: <20261026142705.4564-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <at82NLzM7g8HGgum@boxer>
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com> <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maciej,

Thanks for the review.

Yes. xsk_skb_metadata() is only called for the first descriptor when
skb is NULL; continuation fragments do not call it. So
skb->ip_summed == CHECKSUM_PARTIAL means the first fragment requested
the checksum.

I'll preserve unlikely() around pool->tx_sw_csum like this:

    static int xsk_skb_sw_csum(struct sk_buff *skb,
                               struct xsk_buff_pool *pool)
    {
            if (unlikely(pool->tx_sw_csum &&
                         skb->ip_summed == CHECKSUM_PARTIAL))
                    return skb_checksum_help(skb);

            return 0;
    }

For the drop path: xsk_drop_skb() increments tx_invalid_descs and
consumes the skb; sendto() returns the error from skb_checksum_help().
Since the descriptors are already consumed, retrying is not useful. The
current metadata validation makes the malformed-packet path effectively
unreachable, so this is a defensive drop.

I verified the propagation in a local QEMU test kernel. For the test
only, I temporarily changed xsk_skb_sw_csum() to:

    static int xsk_skb_sw_csum(struct sk_buff *skb,
                               struct xsk_buff_pool *pool)
    {
            if (unlikely(pool->tx_sw_csum &&
                         skb->ip_summed == CHECKSUM_PARTIAL))
                    return -EINVAL;

            return 0;
    }

and ran test_xdp_metadata. It failed at the first generate_packet()
sendto:

    generate_packet:FAIL:sendto unexpected sendto: actual -1 < expected 0
    Summary: 0/0 PASSED, 0 SKIPPED, 1/0 FAILED
    TEST_RC=1

The normal kernel still passes. The test harness does not print errno,
so I can only state that sendto() returned -1; the injected error was
-EINVAL. I restored the source after the test.

Magnus suggested a distinct counter for malformed packets. I agree that
would be more precise than tx_invalid_descs, but I'd prefer to do that
in a separate patch instead of extending the UAPI in this stable fix.

I'll address the remaining feedback and send v3 as a new thread.

Thanks,
Rongzheng
