Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66735AC12;
	Wed, 22 Jul 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741790; cv=none; b=IYJzrktDcfML5EZjjIwTnglv6wG/voh1sdbSak5PKmFkCH5iIGB0InAplP6VbTOtp3sfuC0zE2ukoUZKMv5JpbOEXrbZsgAzohopO4FhflfLYIbiFB3wfS182KaqokZGBzwjLQ+FcfC5U+uOlgZmwsfVoooSMNo1/vl0ffHU7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741790; c=relaxed/simple;
	bh=DlW56uPwyY80Pq1Lt1pXe98HDdxPkxnkuilg8NA/LQ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RfJmgXvefkQm33jECKQteqi0FspHreX/vfa6D6MWutuKgvNJArm8neR/URfX9HOFZsbdlGZrlsktl06FoAZSJy1mUWRbJFK48p+OzEtYgn5gbFTYsB6QfWmiZHCf+QJiZg0H6ThYwYDlDArVbTp6tVq/Gzk0khkhVfCFvQEbCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=3B996Jaq; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="3B996Jaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1784741781; x=1785346581;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=iaCjgNfgkyjQUd1JMMz+MNNOJna+zo9bblFWecNE/nM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=3B996JaqZ2tuxXWKQxxBmpMBWI7kf8LQQfztVJ1QGKxacptKlnRx35lxbZRVS5qR
	 wc5ytiKR7kbIRi/wFBcZHFIta83escDoKhPeUVWwqqagrN/tsmC2M/LipllEM7Hj5
	 CONAKCgAyGfFF3sMLthdVuhhQYFOUYK8EbP/b4m0WCKtf0o9J6wzgEHKQ0Tvl6fRv
	 LsVnairs5iYYAeQlQ5VtaYseuvEertkO4V5DQ7phG4EpvYC1L227sZohK5uXPwDrZ
	 cbD77McdkuxuCYtl7RdkwW7O1Aq9epxGoLiZJqpRitXplB8nwBgjX2E1BZ1Dh13MN
	 zC8umorN26nLorSB7A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mc0Er-1xPlIw1Lwt-00dibE; Wed, 22
 Jul 2026 19:36:21 +0200
Message-ID: <f3fa0bb8-7ebf-482c-a98e-5a544305ee00@oldschoolsolutions.biz>
Date: Wed, 22 Jul 2026 19:36:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Subject: Re: [PATCH 4/5] usb: typec: mux: ps883x: add a delay after writing
 config regs
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-4-cec86d0b909e@oldschoolsolutions.biz>
 <al9PnLOTW-1OoR6G@kuha>
Content-Language: en-US
In-Reply-To: <al9PnLOTW-1OoR6G@kuha>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:89CBpbikyVWecaVSTBdA74uPvvbpsGpEa86gtVYmabZViHCSM9+
 zDP32ZFTiRD9xeH3wHiyNTbEGGSGN85Uhclj/fbn2pHopZwdADL0W6+2RKXjPKjczqgQihS
 13JkZdegcqtZh5a68urDtPBCD+7dzB4/LlJqDNfvqSwzw4XwIOSsi7Ho2U7dKMCmFehhZ57
 HHbXVi5/L6Z7EaYzMva4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NNT9gKsEBWk=;7ymG6eZ1YgCIG7K1fCrFlSvXCY+
 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
 =

Hi,

On 7/21/26 12:53, Heikki Krogerus wrote:
> Hi,
>
> On Sat, Jul 18, 2026 at 07:06:32PM +0200, Jens Glathe via B4 Relay wrote:
>> From: Jens Glathe<jens.glathe@oldschoolsolutions.biz>
>>
>> The config regs seem to need a few ms to propagate the changes through the
>> system (like, PLLs). This improves the hotplug dp altmode success rate
>> on the Lenovo 40B0 dock to 100%.
[...]
> +	usleep_range(20000, 30000);
> /* <explanation why is the delay is necessary> */
> fsleep(20000);

Thanks for the suggestion. It will be in v2.

with best regards

Jens

