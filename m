Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C64472F6B;
	Wed, 22 Jul 2026 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709935; cv=none; b=juFLV65MyVAjYX89bmGwBEsdjhY9F62TkZFUbOFAfByEw68PM/XL2WO68pCJ+QvtfB8sNvC/Pt2qsot+GvoRHVvET/LvgC0atsF96aavIA+BlGBK/0l8LivGziCnBT7pxxMA2iGE95BmPuc/v7b9m+8F2c+86YqzzyDuoxUBvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709935; c=relaxed/simple;
	bh=iciwrskWuOo/beaAgryEWYkM/Q1y9IW8mIW/Yj7mM+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOr7aFc/ptNz33tqsN8jtIiTjHkxo13xjAp4veChIHcNsxK1lLJnELeZikISz31KtoKvaBy2lGENlhW4TpQNNqk6XjI/RiSekMb6ArmCx6iaFGuyD1vIrAbMWbwDFsP/zhe+8IsSRaV29lWUmHQsZ6tWF1xJpUa06ecch/mAK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=ULtP0+x0; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="ULtP0+x0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1784709909; x=1785314709;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=iciwrskWuOo/beaAgryEWYkM/Q1y9IW8mIW/Yj7mM+0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ULtP0+x0DvPxDdURzquiPEUkVXVDo//0OR3My7HnBRJSxDuycvWJMwVpf1XfD6Mt
	 Pa8KRpnqBMpmi0mDsONGFlaJXxmsZtK8OJ5nx2IMDxuo5NurLhqEQQ1DXLcVQUJAp
	 Z0fDeIt7ZwTldgSuv7u9k2agPMTxxSRmxo22mcl3aFik8EjLi0j6cYFiwXKEJ0TD+
	 CQGlv4N882gn0D2nQt6Xn/abjT7FZXxd8x2h5Fr3Hh9sQF/2Rk7dYyI3c8iLa4af+
	 5T7J+UlcdFKZiuMCRKWzcienOCbzybfHcbXsVvCdfNQW0557PPcKhNlncNj8+1w1M
	 TWnXmypPmLU7PuxEIg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N8GEY-1wzduX05aa-00vQ9l; Wed, 22
 Jul 2026 10:45:09 +0200
Message-ID: <a50294b0-b651-407e-affe-49784fd84ae1@oldschoolsolutions.biz>
Date: Wed, 22 Jul 2026 10:45:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/5] usb: typec: ps883x: Return -EOPNOTSUPP for USB4 when
 parade,disable-usb4 is set
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-2-cec86d0b909e@oldschoolsolutions.biz>
 <6vg2kezxu6jguqassp2l6rsx3cg7ja3rxffitzmzhtbc765pnt@m4lalzge22td>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <6vg2kezxu6jguqassp2l6rsx3cg7ja3rxffitzmzhtbc765pnt@m4lalzge22td>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FlHs39OXsevSVY95IWpPK0uqWWhUn/wGxogUY/sSiKFhWj4zQ7i
 ZPHhKblqrb0GWWuU+mO/gnRTcPN3LkNIoAi5V2odJ33qPg+ZIOqFrWN/soHpPAXiBNDHa2R
 WgpJwLNUlGunphTNBiLZMUddQzfptkCQBxscdeuojv/2fqS7/bZv0mZT1gJE5idE7aipyTs
 8RbkNs0xeNuA2xr6xFBqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c1boM3WCWm4=;FhdfGWc2Yr2GBXCLfPkDr8+YQP1
 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
 =

Hi,

On 7/21/26 19:57, Dmitry Baryshkov wrote:
> On Sat, Jul 18, 2026 at 07:06:30PM +0200, Jens Glathe via B4 Relay wrote=
:
>> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>
>> On Qualcomm X1E80100 platforms using the Parade PS883x retimer (like
>> Lenovo ThinkPad T14s Gen6), hotplugging USB4-capable docks such as the
>> Lenovo 40B0 results in working USB but no DisplayPort output on the
>> dock's HDMI/DP ports.
>>
>> When the dock negotiates USB4, the retimer receives TYPEC_MODE_USB4
>> and forwards it via typec_mux_set(). The qmp_combo PHY then selects
>> QMPPHY_MODE_USB3_ONLY because no classic DP altmode SVID is present in
>> the state, leaving the DP transmitter and AUX channel disabled.
> Would it be enough to make QMP combo PHY to treat USB4 as USB3+DP for
> the sake of this issue?
AFAIU, no. USB4 has some tunneling protocol for DP altmode, not=20
dedicated lanes. Therefore you need to either support that or enforce=20
USB3 DP altmode negotiation. The role-switch on the qmmphy would be too=20
late IMO.

with best regards

Jens

