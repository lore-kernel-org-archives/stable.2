Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4103B388D
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534902; cv=none; b=iRgEZJZBESoHHqjJraGys65GZN+ksOCtqVor8en7TNpEnO+OVdkNaM23/S0zIqNXLCCJWa1T7sIstAzIo32g9mng7BWQd4ACrWLtrjlqbqT3sIiDe5suf4YibVHS3JJl9jOY49NhWsM8qGJDe4Soti48n5WouzOp8P337LbCjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534902; c=relaxed/simple;
	bh=soXokHFCzmLIi+VJ1I3iTtbX0+pzsLftTokWbQ9P6Cg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HhBTlCJa4JBs/oOab1UhVo0owAQZfeurfn9aHYgcxL+D7C4jEDqASiLkK+SEISxZZEFg5t3l0++zmo7X3E0pjHbHxMtTN/HP7rnt0kJ4qoe1p1vpdV3ZFSHAeu4Ax3XJSN+OOFNHc337cJB/8kySdLB2WUbYuOSniUr5aTTMqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=k+RmNbcm; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="k+RmNbcm"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3410209aa6aso893865eec.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790534900; x=1791139700; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yqlZZ1RhSPYEVPxxu8nVXKmxPulry40jU+yUEBcr1Ew=;
        b=k+RmNbcmk2D7AP0kteNYpcaZdc/OxOoy8fVJMwEAKZurJAThwJr5YJOZ8NitnpImVB
         htLitsit0bfiW+cFgggLx5SZGCgVZ33wVyQIqpPA7OXzBXDiDFwyZwEVYao7D9AEVetl
         M3uAwn8dDROWtN2sjqzmbid8rTJjyeXbVa2Sr+LP+d0g7sxLpMCHIVT3rKPyifrM/PKe
         /cqbOOeUGoqFIka2VzrgEwWH9LMR2FmsIDGxzZObx2Ok7MGVyYeUsbJFh3PF8mgPPpf9
         dBqVwmjmD5Am3UcUIDfBG2EXGAtCgHKUBzgeppUALzldMB3nQJ9aYBGj0B99nh5rdgun
         7jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790534900; x=1791139700;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqlZZ1RhSPYEVPxxu8nVXKmxPulry40jU+yUEBcr1Ew=;
        b=2fUJ2V09YTfgeL+sQC5MK7QHi5BqM08i2hxOcKvVLhg5J5PPKBfiDqxXMevyJ0j1VL
         s0Y2HcckPOdFovkauet1LlAgjnl9HncPU8ESOaM4rOxWXLJyz79/NandyMbmlGe4auUB
         xQSHfmKqNQMaSISaka1G0lvsgXYa1GBkRpsvVxXC+rV5NWj5FpIAZklYtl/fw59UArNB
         eC0mM7c6qedjelcGui2IAhnVl89k//3ut3t5vlNZ4W3W7W7WY3/J5ysLFjysIlc65cQ2
         nV5L+Wv8wtBBtYDs5joi0ka10fgM6OZGIZHv71sKmAgHLhFv0R6qkTye2WtZoX3258A1
         91jA==
X-Forwarded-Encrypted: i=1; AKwUvBz+vJ+SA0IPPCk53ehKRD/wyVTOzknda0vMZDa33tDupWPNuHQhc7yMk9Jy8hEfUjEZdMtxBdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJonn/CatYMhb8lhWeZYY4+a+P1X7Q07ZssdC/qA2r+jj/hH7hc
	3XdSvY95PazHCicKntPmb4mXQ4yig3S6FBpyX3n4j6JQ3ht9CuHSspohcZO0iV8Quww=
X-Gm-Gg: AYBFou3hLB3EF6U9bYnfSLAmEqLnzLAkXsXEOR5UfgDztCkDQMJD9a2OlwGU14EpqML
	1ATjTfQQOpuqDG2DGpQ24ZGS+O0ayv7u3e6/JG6Fv9wFXx1aAege5r53lhMcBLYo9HNBuPQKz5z
	A2DHYXUIEDiiSkZ/tWWi7T+G20QzJXIGKhqDp6R4gYeOrdQlIKV8F/TuD8wHTir7jsLIcWyj3hA
	FNJ8QClmu7XF3B+rEBQT8yG5HrcbKv9g7liTnNV0hJHvpudCzser+eG2F213hOojCongDdpRTBo
	KyPedA1yDFbhLD+C6uSDpDkmbl33w63tZgLhi0WgpEwO551+gToIJjCNU0poeC0rva7iQxk7NWn
	XVbvn4UQcg3KW7+wm1DV8hyf/GIUAHCHz7woT5cfyJicpYZS7RjVasRyT6moZyjXYabWrHu7wDL
	QNhT71kfCwJP4ml58lKMWd2c64ZaYmgSUplgev5oT2/d2Kv8seJwSHymJDCIeYztuSj4I07EU=
X-Received: by 2002:a05:693c:62dc:b0:332:946c:4778 with SMTP id 5a478bee46e88-342721805c8mr5904589eec.14.1790534899604;
        Sun, 27 Sep 2026 11:48:19 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm2044300eec.15.2026.09.27.11.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 11:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 11:48:18 -0700
Message-Id: <DLQBNCNNWZNO.1AIPW6NRU3GWS@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Raviteja Narayanam"
 <raviteja.narayanam@xilinx.com>, "Wolfram Sang" <wsa@kernel.org>,
 "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>, "Shubhrajyoti Datta"
 <shubhrajyoti.datta@amd.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [SPAM] [PATCH v7 0/3] i2c: xiic: fix SMBus block read and PEC
 support
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.22.0
References: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>
 <arkAZJEJTtNsCjmF@zenone.zhora.eu>
In-Reply-To: <arkAZJEJTtNsCjmF@zenone.zhora.eu>

On Sun Sep 27, 2026 at 4:40 AM PDT, Andi Shyti wrote:
> Hi Abdurraham,
>
>> Abdurrahman Hussain (3):
>>       i2c: xiic: preserve PEC byte length in SMBus block read setup
>>       i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
>>       i2c: xiic: don't clobber msg->len to signal block-read completion
>
> pushed to i2c/i2c-fixes-2.
>
> Thanks,
> Andi

Thanks a lot!
Abdurrahman
