Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7B3CF045
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179904; cv=none; b=dkmYsn5q/ZAwhkPOzcgFm67BEBNz4oCXOORPR70Tabvj+HQQRrI6s/YfMXYDXddoKoYJO/TSvrRWjxL/Oh1FqVZBuo9rvdeWq2KmMAY9zPTu301DLOFYbqgoJbGPvnGX/zvah6Jj+X6VS1Rwz15+SfNtMzV9uF+YKC5gVzqmG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179904; c=relaxed/simple;
	bh=Un6siYnM+ZFWlTw3zCz0AopGBG7MRAKNI5gG2PmKCGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvVDANJWTnOIoiVGUVzFssX6lDnaUjUg/NdLObo+Zngc8tWXHLnTkHi5Hb/ZIQdsGbgAV1f7cDBaW7JtOUQdJnroHkkz/iJnGxHLxckSs7DY5P7VklLtDrtZr1WTorsT5KXt8Ha5DlxoMVtABWgM5c2qj/dRMBgvaPcMKMCsGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8X1akrS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8X1akrS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954df200ddso20053915e9.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785179902; x=1785784702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mwsGW+Hk5uHQBqnL2Eo2zXFB4YSPa29o9sOJAIzMO74=;
        b=H8X1akrSC5bXF5sqIQcvtnldVKDHo8GqQ+s+25pMzInhmKNaU7WEA4rrLtcoIeBK6v
         /RQnSOPs/flzqFf4i8UcU94hv6AeJY3UQTIB/PpHXGoYTdspakUjDnXhv0N1IvccTFWV
         zGMr80L+XS4gf7elK5isMWQeLCB1FCkMrbBdsI4HNSxs44H8Z74qYpToCzSx0Hleo9Rt
         t614F0LiEeMmJmpzvqW3Mu4gdPTz0HSUDT30kb0PHFCCkC86SMESfLbZKN0CpVEzpZ8r
         Ytbblk9IAYJak1EWgvWgSjQpGhq8OS/+lOQVe+jVWVEJWsscbNXoAX5zRFjVv1lH/UFM
         1wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785179902; x=1785784702;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwsGW+Hk5uHQBqnL2Eo2zXFB4YSPa29o9sOJAIzMO74=;
        b=Gy4ZBpXWL/VQqN+PXpsGJ/dnqthfbNxUf5h+X0mNiLQldwwx7raSbXImhX7X7cAzK4
         Xo3d9TwtKJwO5ONxO34tCcyhYRl7JP4LKAdvF16PTdnjwC3rybJwZRPkmh9CM0dt8XpG
         xLXD0GIZoTSwlpdqsrKAgu3m/OqClbLvsrGI9lvn2G5Gd14rkRx2xDzBO9QbIjYp1d6Z
         Q2MtP1YRI4l3yg1fcdIc8uALuj9g0RCtxtjUu0EL8VheHQbVNNygkujGcR+/piFWtrvd
         KLzBcfdY/XKVqLSU0MbAb6yXWIrUYE8tKYO47sALkLSxtOwq9rKNGxX2ejFRJBoU072c
         Tjig==
X-Forwarded-Encrypted: i=1; AHgh+RqsBKY5VlmgZshb1zCjmSdn9t+OBk4p0Wf3xIsYk1sooGt+0yu90duVtlwLwJgJmMpDm8BGCr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbt5gdDjPAQ52XW8xFArwS0d2kUWUMZiabhu59a3p1O7kXnT4G
	gKlPrNNqcuJigYtG0Wp+a/ZMGFYQglv/qZiY9sYAWYSQgIVH7p1C4cIErYHOYQ==
X-Gm-Gg: AR+sD10yq7m3BgTr/K2omdROxD6/JaIQAdfHfPdZ6ch09Vgum/uZDqIzwQa+X3mQwG/
	cfVTo13qroKZcwiXc9Z5sRd1JQdmYNkFditVAw5LOB38CIfvZmnh+Yc6NhuEmZT1DUwUDEC8EMB
	Yqa2/Z3sMe97v53SbtE2tfAXnOtOzMJQL46XUwMX3hOzMekk5v7vkUw8WaDbU8hOLbViAPfLUtx
	+NZFbaWtlvSKFVPaelHBExb/WGKp1aJD42wirZ8unFBF1QMKkWi8BbN8BdTA4OgGbBZelCzb6b6
	Fxqc7MX/cDa/PjkfHg86f+NkusSxFr7FaZA9gt0XTAmluFQB4oJD4SG2F78A8IueQ3pP2pIziHu
	Semr56pAutbO3mD5nDNFPlcfxjf+dgAL8rwE+H/N5Uq4yYmNuxCbKRwt4OhtxPRv6/+PVf8oR4X
	cxANDL9W0Lhi20zyevQN9vMQ==
X-Received: by 2002:a05:600c:4444:b0:495:6022:5a14 with SMTP id 5b1f17b1804b1-496c4fe08f5mr4096005e9.34.1785179901692;
        Mon, 27 Jul 2026 12:18:21 -0700 (PDT)
Received: from foxbook (bey56.neoplus.adsl.tpnet.pl. [83.28.36.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm50020765f8f.33.2026.07.27.12.18.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Jul 2026 12:18:21 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:21:30 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usbcore: Add quirk for 255-bytes initial config
 read
Message-ID: <20260727212130.4a6bb49f.michal.pecio@gmail.com>
In-Reply-To: <CAFgddh+1Bk=CFkKYNzB=L++UejkhCEcTHp4A2JL2v+P6uBuF2w@mail.gmail.com>
References: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
	<20260717195336.98500-2-nikhilsolanke5@gmail.com>
	<20260726182946.79a4ef98.michal.pecio@gmail.com>
	<CAFgddh+1Bk=CFkKYNzB=L++UejkhCEcTHp4A2JL2v+P6uBuF2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 20:55:27 +0530, Nikhil Solanke wrote:
> Regarding the "stall" wording, I was referring to the condition where
> they fail with -EPIPE error when these devices are connected through
> external usb hubs. The directly connected devices I've tested
> typically fail with -EPROTO instead.  I'm happy to reword the comment
> if you think that would make it clearer.

Understood.

The reason you see -EPIPE is due to the marvel of technology which is
"transaction translators" in USB 2.0 hubs. They report low/full-speed
protocol errors with STALL handshake on the high-speed bus, even though
a new ERR handshake is also defined and used for similar errors on
interrupt endpoints only.

So your device doesn't stall, it just disconnects as usual. And with
a USB 1.0 hub you would see -EPROTO too, but these are rare today.


My habit is to make code comments generic - I don't know what devices
will use this quirk in the future, so just write something that likely
applies to all of them - "break", "malfunction", "fail to respond".
But I also describe precisely what problem the quirk was meant to solve
in the commit, so the information can be found with "git blame".

Regards,
Michal
