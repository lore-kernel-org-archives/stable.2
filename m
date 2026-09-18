Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF94340260;
	Fri, 18 Sep 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742662; cv=none; b=t+OvqkwysRhWhd+LKlskq9kW1qUXl+BsqzaYHaythxpdGOLOBlgWS7tWIhAG2CMIii+DlQ1sQ2ofR2awhNyEI1CpLYpw3kRb/qsbyIbG1oZHZ5JXVG4ah7KF5zpKQ1Kj9TIMHJQ8PM4G9LLHUzBzOgbU/uvOPcf3tymsU4b5rWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742662; c=relaxed/simple;
	bh=UEKJ21gw1Dw3LJ9CKd1SZJBDvs/uzGNvB87MAehHrC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAqiWOHHc3+nXZpYwXZAWdrf6Bj+rD3OUsKptUO8DiApl8OG7/R+G9o0XKOUO13VeKYFfXA72i2HWMbVwDyDjRfoFhqaAHBa03Ne2Rh6myQ2qdn6QPXkfdyqRj9nR07hMOEg2RjiSmDiVJHu2n02uhUu27ltcVFzne5zrKLKs7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=Em9zythH; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="Em9zythH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1789742658; x=1790347458;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=UEKJ21gw1Dw3LJ9CKd1SZJBDvs/uzGNvB87MAehHrC8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Em9zythHedAab0tT6vtSYz2OGXzNRgqm6cWBNXmMubmAQT0LsW2bs/DGlQtPkdst
	 CWmTbipm7HyuwMCKR+baeeLl0WoLqO0tHxSd4mZKnyybw6w+ShOcf+YKQ2Vz/Djae
	 tTnxPZLkjhTkRKIpii0gSZbl299u3EzRbst9VYg4bWWIwUqKByIpKUvLT6+TvSvwW
	 mmNci2Mm+F3Ya5uAkT/iDuFmMTY9Hqq1sP1qT3VGfVZpjp4xIBYrraKM01uBfMSir
	 jKspOWasduIdtf9HXkaLwngdcFSrbjEjscS12873Uq47EwKBuFkG2Rkegse7Y9+/v
	 phwWtCbTDJpAWOg6BA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N5FtF-1wftvp3c1d-00rPlS; Fri, 18
 Sep 2026 16:38:40 +0200
Message-ID: <35f0856d-2f39-4a03-b056-fa22b1e56589@oldschoolsolutions.biz>
Date: Fri, 18 Sep 2026 16:38:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] usb: typec: mux: ps883x: disable USB4 on
 incomplete USB4 platforms
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
 <20260914-ps883x-disable-usb4-v2-3-523c32b4e4d7@oldschoolsolutions.biz>
 <aq0ENUZzJYKZ6V9f@black.igk.intel.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <aq0ENUZzJYKZ6V9f@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5LPT74JtNpAEV3vGrXpAlrLVKmERpDn4nZVgAi8ZLO859LD5EhK
 jDLfgoJCk6zMl9jvgyitALWPMM2foRSx97R8XPPgt3+0C0EfIu37V+69Mm0oIiEyeDNwaPT
 CXUGVLP/JklpOAz7B38q6TeZMfz3NMV8jFko9ijo/eky/cm77w9zYYiT9LfO3fBH7vBKwtB
 CKTOm8Tdk0MZzc/kSg+YA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z3j4yR01WYU=;U0eBHeCaZGMehBIEEkx8rHq2Yak
 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

HI Heikki,

On 9/18/26 11:28, Heikki Krogerus wrote:
> On Mon, Sep 14, 2026 at 08:05:03AM +0200, Jens Glathe via B4 Relay wrote=
:
>> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>
[...]
>> stays inside the kernel and can be removed later without creating ABI.
>>
>> Link: https://patch.msgid.link/20260312101431.2375709-1-krishna.kurapat=
i@oss.qualcomm.com
> What's the purpose of that link?
>
> I think you want to make a reference to the commit 0c8ee850572b ("usb:
> typec: ucsi: Add UCSI_USB4_IMPLIES_USB quirk for X1E80100"), right?
>
> Is this meant to fix that commit? If so, then please use a proper
> "Fixes: 0c8ee850572b ("usb: typec: ucsi: Add UCSI_USB4_IMPLIES_USB
> quirk for X1E80100")" tag.

Hmm its not a fixes tag. It is a residual of the thinking process that=20
prompted me to go looking what goes wrong. So its semi-related. Since=20
you acked v3 with the link in (thanks!), do you want a v4 without the link=
?

with best regards

Jens


