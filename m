Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773636;
	b=2twyit91ekUzDBQrPn+Q8tCOLpZUNq5mLnGADnRn+Lis61b9io/Pg6TeieUFknPml/Fv
	 iUYVAljCD3tuj4GtaqObjwBKUs2tMoqvCljvOMWKtRIX32UONAUKOYjgROORcYyUhYx0q
	 opEz24GFomBqAl0zTyatZiwY3tIhKRh73zYJQfDVUyY2M2FNtn4Di1L40NRwgtMB+zJdU
	 ZTipYpML11WkEvaPyDl3Ua5QsIhHC2dk3XPR4wznQb8CfO6oWdXOp13SYe2HNnRQghKkA
	 k2+rJ9RZru+nPUKixju5CNVZAbMX/NOOyoj4C+88PSLAj1eRqg9RXiEs5FfAshaQUzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NSC/0UBqsHBUxojcMDjRPSsTZlmrWmRR2YvHBxYsfFY=;
	b=5jLCul7GTyJ+xEIfShWXIgHwdaxkOUGDEXux97w2mr5hgZKAUHZ2J5D3hr/pjxm85Tpt
	 7aNYUCp1K7NZ1KBxTQ+8/vqdq+kxOKLm6Lbnv0bHjW797paJyDxrxsgw5+rPgghw5r03h
	 YvFow7CZgUDMPjoiP3zoB2IDUqSyd4C5BVCHbT5eqNGhAsUS6L93DA+oU9yNMh2FmsUN/
	 Ow6uPIBCdMIpelzQwITpLcqDk9X1tUXvqbhIvqpeypf8bn3uzxTKHMMh/YCTRvAfMpxZ6
	 EaAJb9EbCflKw5vPN0sWhQZExFoeARfYFjNz/oZqCykCA95wn99K8BhvJa2EEdS6rkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="S+d/J/Wl";
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD8606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39BD8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S+d/J/Wl
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so557067c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793773634; x=1794378434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSC/0UBqsHBUxojcMDjRPSsTZlmrWmRR2YvHBxYsfFY=;
        b=S+d/J/WlJRNCpBsfW4bmC6NRLzKerZngGI7ryYluGCIQicyRzYIeW0FxSQrrq6iQfs
         XpkkaTkORuL4jo/EZ71DM1RLLYBz37U6TAiRS3Kx7I1hHJNzo7u1aY0E8wTvBFuAS0kW
         51CdSq8lnp4zahUDi/eKvCJArYlROECM35fE5+1aeHTZkq+Ouxjck2ao74zDsQg+DTSg
         MDx4tQqyNcup6zzVFf0X1DNZ9a4jxW2Kkh5tWIL63roGZARTVYQ3c0iCVdZJ+0nTHdMS
         jeua6LhDQgaqKk+HGdf6ylzvFUHMCx7+eiJVsdX1IHSf0iwcCE2lzq6OgrHhnEymGMdr
         rJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773634; x=1794378434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSC/0UBqsHBUxojcMDjRPSsTZlmrWmRR2YvHBxYsfFY=;
        b=yJH+ypXQSDzHzEgaZwX4iY6R66LS8+TXmbBA2yPp3dI3d24yvXRx3SVNzj+ijgj9g9
         5nVKKqTgj0m3gDRHgvjmACGQeO/sensrDD1HHCBt3vXABsz0SrNFxqfYmWANyotB1Mdd
         4QUd3DcN9IHabpQeYQeTScES6x1aaiQZRgoLuPHmCPPsAQXdCttP8tmh+DFXMCOiDKD7
         8vgKz1DyP4sqodsQU9nMZ665Hd0niJEVeU8QzddglP8L6JDz/o0clKPM4ivzV/UhysjG
         uHpXOadPTMhXpn5zevi8i27uhq0f8ghQhKa94IjqjLw+9585XtVZeynKeMAkSIMk+6NQ
         ZNBA==
X-Forwarded-Encrypted: i=1; AKwUvBy6mJR+MUDHOQFBPZ9aR4nj4H6JEf+B6G5pLHx47TqoDMCCAvwxOig9ZSIAmJAXwT57nKRcIYY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vz/1eWREVXLWT3ZlYH5+2mIlbx6EHytnkPn8TCq90Gh2SODQU
	keDW32j5ld9N1mxr6TJ71chJAR69lq1e9LKsd9h5x4L7Wv2VCzwBwRerGms1UVA1jQQ=
X-Gm-Gg: AYBFou0O3o66CCpze+7/3U62hus/t2/ff+i88DY4xz+X2D6gQqCR5+oaaHnTmV9yegL
	0jw/rNGK6gIoUOYo5y7JGvFS7tLIqz0XhJdZMWOQhzKy9s3NXyOkeJk1uGv2oH5FKAzXM/lt7jZ
	9pLCHolJHFFhVaM3tku1bk1eUnGxgxthrJAfFFbTCFZAvW87M2F/4F+WWeLG8+pBkhPRrTVLces
	gAij0ucMJrDoyKZHOBBkxB2RmumhImAn9NXb3QSbpNoogBxwxoDkwYFMlrYob+bLbYTYCzuzzGC
	TGkXNpb9ldsWqhnvZuxBFAkTMWabnTWJaEaVxPUfFQMGP/trlMIr24tzA+R/MkMIgeTMueIk2ao
	dgOGjlD2Z65LlFShiM3salQzxMOOZ/ePz+7AStsdPhh5pCdjSaoKSCrhjz4av9fkx9MNC0vwNYg
	O1t/mp5rrkOHHlLYaDIvXvuCsHsZ2Bb9OQQbPRH06cFeaYFw9asXWWHlK9JIrWfDgFjd2fW/zZU
	qE+xlmvSG9eJlnpI28Zy8NxexxyrzpaXXDjD9jt+SZaEEeAVEPoNK9oZ3ynKU1cislbFC+tuhG2
	kA0VuiTc2n7kFaeuTl5H/T08/8ls1K48mljSFCXvg6IuAx3ukY7drT0ZRbpv1pneZcgkFDo8ka6
	KHTyIWkt3uJGtPZeRlgpCWhwaL6/UitPJv0uY
X-Received: by 2002:a05:7022:b887:b0:143:2719:f800 with SMTP id a92af1059eb24-1ac5f742576mr20295191c88.40.1793773633660;
        Tue, 03 Nov 2026 22:27:13 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:744:cf40:a7b2:e78f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2f7sm4955756c88.9.2026.11.03.22.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:27:13 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: netdev-bot+sinfo@kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willemb@google.com,
	pkaligineedi@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] gve: bound the device reported rule count in the flow rules query
Date: Wed,  4 Nov 2026 15:27:03 +0900
Message-ID: <20261104062704.1882348-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179377314801.488859.9571867900418118906@kernel.org>
References: <179377314801.488859.9571867900418118906@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Hardware: not tested on real gVNIC hardware.  The overflow was
reproduced with a KUnit harness that feeds
gve_adminq_process_flow_rules_query() crafted device replies under KASAN
(x86_64, kunit.py on QEMU); the harness is not part of the patch.

Best regards,
Yehyeong Lee
