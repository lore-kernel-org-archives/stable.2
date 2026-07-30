Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F38411A07;
	Thu, 30 Jul 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430015; cv=none; b=D5Vh6+tsXQtZp7o2GwkYrqqNuGzJbDcKthaoUPfeyyzfg+nyM1kooyyxqG8A2UNx/4+X6zF/Dqcjf9O78rlFUspukKo5R5Z7rUGejtTg3Kf7hE5VR1p3p/GaRIDKupKqACbbmni0IlExcx8W/0X1BjIOois+OJBbkkUj7dKZYxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430015; c=relaxed/simple;
	bh=onGkg8Jgu/112ooEdvAORGF6q7Or5Til/7XFiP62eZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1+UcvB5Q6UJXs5c1munEodeua23XegMdegj1lx6QAYxiFyFg5ZWxBHySBT7rDglYXJNt83+md0ubv0d1VFlWf7zsRVDd66/CVfW5NA8qcUvMZyj5J2qeFJEvAgzw3sIuLSY6x5cnoIrilux5Ze1c9VjTlGfmvJiZaOSnPgEDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XnWiq9nc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XnWiq9nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785429997; x=1786034797; i=w_armin@gmx.de;
	bh=AdckCz7pdoHlt9/VQqkWtwB4yCsCzcvBrC7k98bHX5g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XnWiq9ncgzP6YxlP+4yk2//Z1YGXE8cHvq3/IjjQDx9r5PBxQoKWNg5quycGB5te
	 d77msUQ5Br6C/3u83LgDJpDOQz6ueQXJGoFPJlLkQx89ImTbHnRQhYtIJHW21Z1Ka
	 0gvEfuloDYQw7PbHX1InJg/snXu2u4rlvGXj/89kGuUN87Luyv08ZMi4dcf4gRw1h
	 MxmYTY8pcCB36fnKOZxMSi3YPL1kAODY05JYmy1KhzN5x3ZdZBBewd8g0UwUC+X8Q
	 9rAZ9McSBUbrr+e9kQHUV92lfwwx4hc2mz97rsRbDOoePC+ZpNy9dn056+nIu82dm
	 LxR8a87khG43eUDDbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1wehr13nxv-002AYH; Thu, 30
 Jul 2026 18:46:36 +0200
Message-ID: <fe8a69c9-83a4-48aa-8904-73ce70ef7a62@gmx.de>
Date: Thu, 30 Jul 2026 18:46:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] thermal: per-zone hwmon names break Steam Deck fan
 control
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: regressions@lists.linux.dev,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linux PM <linux-pm@vger.kernel.org>, linux-hwmon@vger.kernel.org,
 stable@vger.kernel.org
References: <cafd8af9-c6e9-4bf2-b496-23e796fbc9a6@linux.dev>
 <CAJZ5v0hWDKHXO5d-rgp_TMiS48fHY-cTxf5r5rGg2eBNpNtVig@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0hWDKHXO5d-rgp_TMiS48fHY-cTxf5r5rGg2eBNpNtVig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MCG8bDks1TuqiQ7sAmSUbMvEMRtu7Ez6L6n4p9a3Z6ky6touQO/
 K8Xe+r+IqkMSV0et4c4i3NBvOssr64oLGUDmLDCB/3P4ATk4t9rDXYCedbCJzZE7TShkz2g
 ndOnol8WZxh2YDPPgiYzgbFRkOa3TF1jL1s8yccMfx33hFfANO3hvNWTFlfox1UIbOc5lD3
 5HCh3Nv2ShBh4E0ApTCew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eGWZjlkTVzo=;eb5p6C87byQNuvX4w0jWE1xTylP
 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

Am 30.07.26 um 11:33 schrieb Rafael J. Wysocki (Intel):

> Hi,
>
> On Wed, Jul 29, 2026 at 10:50=E2=80=AFPM Matthew Schwartz
> <matthew.schwartz@linux.dev> wrote:
>> Hello,
>>
>> After upgrading my Steam Deck OLED to a 7.2-rc kernel, the userspace fa=
n control daemon that I use stopped working. I bisected the regression to =
d6323469bcfb ("thermal: hwmon: Register a hwmon device for each thermal zo=
ne").
>>
>> Before this commit, the ACPI thermal-zone hwmon name was acpitz, while =
after the change it is now acpitz_0.
>>
>> The device profiles for fan control rely on the exact `acpitz` hwmon na=
ming like the below code snippet:
>>
>> devices:
>>    - hwmon_name: acpitz
>>      nice_name: CPU
>>      max_temp: 90
>>      temp_hysteresis: 0
>>      sensor_name: temp1
>>
>> So now, the profile fails to load with:
>>
>> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
>> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
>> fancontrol.py[40528]: Warning: hwmons not fully loaded, retrying...
>> fancontrol.py[40528]: Traceback (most recent call last):
>> fancontrol.py[40528]:   File "/usr/share/jupiter-fan-control/fancontrol=
.py", line 606, in <module>
>> fancontrol.py[40528]:     raise FileNotFoundError("Failed to load hwmon=
s after 10 attempts.")
>> fancontrol.py[40528]: FileNotFoundError: Failed to load hwmons after 10=
 attempts.
>>
>> Because initialization fails, the daemon never enters its fan-control l=
oop or writes the requested fan target.
>>
>> This change was also backported to Linux 7.1.5 as commit 996957016bc1, =
so the regression is present there as well and has led to a userspace ABI =
regression. I can look at accommodating the change on the userspace side, =
but it still seemed worth reporting as a kernel regression.
>>
>> Thanks,
>> Matt
>>
>> #regzbot introduced: d6323469bcfbda91f0aa89b7b39ad45fe822ca5d
> Thanks for the report!
>
> I think that commit d6323469bcfb will need to be reverted.

Would it be possible to instead make the new behavior depend on a Kconfig =
option?
This way we would give userspace time to adapt to the new behavior. Removi=
ng it completely
would mean that userspace will newer adapt.

Thanks,
Armin Wolf

