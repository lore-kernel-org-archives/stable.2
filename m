Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA08329E5A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214265; cv=none; b=VfUriZVLDSBo18v27Xt3rEt0+s1qu3xS0BRmIr/fYqFAjJC8JqxljAdyoP/6zTD4KZb6SQs/xizH8WMtVqYuQk5/SIYme5SVZEm42kU90pjNcQ7zyr+kE13ek5UaqwL5GRuroy9uUM8rkBokh5VsENIzoSpWRCgQAEdheHC6wlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214265; c=relaxed/simple;
	bh=TrlkWhLUYKYqpfyhjFtzdNcVUv+jgrxruyGC3ITjANk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=uvYze0emT8+eN5GmzfuF5SCAPmP+LB3NrrdKnaufE5uxL5gb8Ni+MX+pl2NFzEF3I3p0gCOgDB3q385X83SulYCJdcp4n96Jvz86OwmWF1f4JLyWHztl9MxEaQc6rhhRqyf0geCvhp6KnAY794TuV+5yyG82lfO+MnPTMSBwRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=LZTm7zvC; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="LZTm7zvC"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33bf5a1c4d9so1568640eec.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790214263; x=1790819063; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WltkXwT4z+eov17Qfylxi2pHojB612CmH3f4OFtUAec=;
        b=LZTm7zvC+LVqyxsBfBCSFXDg3ILhm0U0VQXEzsfIRqvz/+8UcGAwtrn43Ylkqf5uVK
         Lhh0UyAbwkR2OdPSK9OoXeTSlJwi73XWd86Cpo1cNhPwUNxMvUwfMdytl0CblXGCPkyR
         L1f2zFTTlwgg/R2YpCKo+MxJZRGW9iM4Xhw/EbafG6h0USWaowCToS0V3HfnmsatEFpV
         PNdHB9O8OkgTke5taGtTlNDlWLOvRoj0LoVSo3kDpl/SZY3YGchIUYSXjLCTnR01Sis/
         m47Ka232wd0vgCVs/k/3gLXA8sNVt0wyW/PUma601Ckuijlxcx+dxBp0XXy0T+1rU8sV
         NxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214263; x=1790819063;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WltkXwT4z+eov17Qfylxi2pHojB612CmH3f4OFtUAec=;
        b=tTxOkuodl0243PdVvlU1uiaqOgihX6v0cRPw33ATCoxbNGIaT6tKttrvXVeOE0hCY3
         ez02ZuKL6ceyY3qd6RrR4Vd1iswOR60DnPcWoOQcjtROot2QIaGTLD9B6/5Vz5K8EJfL
         s/DSPovIbK3hhOFFkTcnIhDgRQYrYz5DZ1xwkFClTDuYqZY4J4HsaoWTq0N5AUrtzg7f
         /bXFmgdSp3QkcpHSEd3wVlJ9l0q6mNXMcIZ51vl9ZJbDuURcYdkv38f30Q8M2SWCddvP
         AIR8P/hkOb0j+iRcSTotU2/q54L5iS2L9OCh/y3h8/JUTBLv/qEC0lviFyxmZoPd4l6K
         bjuw==
X-Forwarded-Encrypted: i=1; AKwUvBzrlk1QgHoKbhWR1YTSTysLKMdWhI8TY9ijChUnVPBnTF+5xzNudXji/8VyQA59gDP4roZny8g=@vger.kernel.org
X-Gm-Message-State: AFuF++ky06Mw2A84yRTnblrcU984Euwx57I5ZdfOf8/S68WtAIyn86dm
	78FhaoUXOntfFC6v+D0RnzjqSIcqqLt8s23UBC/T3i0INb9pVm+5etSgDfkdas3OmwU=
X-Gm-Gg: AYBFou0nu/Cl2tQ4UGQLmC8KsQtcBfit+Rc7bwAzCceXdqCOYYprjcnlzVjkiTfjI1J
	2VSv6ZtKsb2UZ0Xp1nDp88L41vaHxXY3Z0ZhPPlAtriDMpAG77zCfMMw5/KSetoBhjfiM0ml73b
	aHXn70hZIAJPv3HCrjirj08ybEtllAnte+RSQk/2ezsuxUBVRBEuzNBIVtwIVDo6xV6gfvpH1+H
	oiMICCILeCmMe/Z6JfonrN0wAlJd5SH4BIz1PsDeKrU7qm310kGRf9Khkb5lANPkrJWIi7ri7iF
	/BvEnSTWT5kAcbeIX6xcjMdRcvD+V+UtNn/cAnvSaOaGWTbSTTakAgt2V3l0JP7TzcZeFIl3eGp
	YOQgeSzrsGJsisiyolQVA/jcwiudwwbtYf6rd/YBik9L6QIFAFY6oXTOOXow5aBN6X+6EWyB6zv
	xjeGXjN9EpGbOEcKw1537SQwl1se4JimBBU6zRxtRzkurnB/lE2xYOuuqIqwSBjcF5UoWLtc9qB
	lja0sEUGw==
X-Received: by 2002:a05:7300:238b:b0:33e:451e:c8b2 with SMTP id 5a478bee46e88-34006f826a1mr891609eec.37.1790214262980;
        Wed, 23 Sep 2026 18:44:22 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm9920817eec.3.2026.09.23.18.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 18:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 18:44:21 -0700
Message-Id: <DLN5ZQ7GWNQU.3S23BUADOK8M@nexthop.ai>
Subject: Re: [PATCH v5 1/3] i2c: xiic: preserve PEC byte length in SMBus
 block read setup
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Raviteja Narayanam"
 <raviteja.narayanam@xilinx.com>, "Wolfram Sang" <wsa@kernel.org>,
 "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>, "Shubhrajyoti Datta"
 <shubhrajyoti.datta@amd.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
 <20260921-i2c-xiic-v5-1-2fca81e810ea@nexthop.ai>
 <arPW6xckt7QMpt7C@zenone.zhora.eu>
In-Reply-To: <arPW6xckt7QMpt7C@zenone.zhora.eu>

On Wed Sep 23, 2026 at 11:04 AM PDT, Andi Shyti wrote:
>> +			/*
>> +			 * Undo the setup-time padding before rx_msg is cleared,
>> +			 * so the PEC check sees the right byte.
>> +			 */
>> +			if (i2c->rx_msg && i2c->smbus_actual_len)
>> +				i2c->rx_msg->len =3D i2c->smbus_actual_len;
>
> I think this restore needs to go also in xiic_recv_atomic.
>
> Andi
>

Yes. I2C_M_RECV_LEN forces standard mode for the whole transfer, so an
atomic block read hits the same padded branch and then completes in
xiic_recv_atomic() without the trim.

v6 pulls the trim into a xiic_smbus_trim_len() helper and calls it from
both sites that clear rx_msg. Patches 2 and 3 unchanged.

Abdurrahman
