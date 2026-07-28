Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196E40DB3F;
	Tue, 28 Jul 2026 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229740; cv=none; b=fc1ic/ps+mnpjYoVAhzxm02lH9fLRSNk+jkHnnnCuuFzPYPYmeZwl0Sw6mejKaP/A/vrQBAFJB5O3NH3NEylxyYO112dgfGZmNubQifSBcEa4EHRFz6M6rdp9zKyujFoj0PrnqLWydsMbg/8koiTt1bApq7ZDWQqXxlQ5DDIQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229740; c=relaxed/simple;
	bh=5FUXQQkvikKIyazralBdsCQmFN55BAlSFjsu7d5xeEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myifqHlIyb1LE8Jp1Dmwf1REBsXCX2Drua7/RFv20c0On85u6T9C3jXvS6iLmoONSdqD295JHsz+4lptAWsVbWd1vteThIExocOOtu+gqCjLzRCUCdIsPqpr39NCtKm41QBsGYZdVcDNyEbsZGiffMDyEaBgmH65CGf09vFg1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IKD7o6I4; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IKD7o6I4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785229735; x=1785834535; i=markus.elfring@web.de;
	bh=xtAupt7qMM1jiscpEnvzRmDa98tHFGMy6OcpC3h1RwY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IKD7o6I4LjrlVR5dFLFlXs8KdHwtedL/Kehf/fZVrQXLALE0YwrfBGdNxKLeUykE
	 bQA7nXnQtaNurzSTKeBfD1TgEUYLfQ/CGaQhdUXtMZwg9qhkgZeqhlsLGkdnOml8Q
	 sJiZHFA3w0u0ruOkisg4ykMUeUgIlsy0VPSXTLbkG69BX3ly4eS0QGlGgrLVIygOD
	 uZwrbPA2H2XQdRwhISfV999QGEMrSU2yQWTr6+B7Q2yDeYfnRb0or1BOBxJDOyhaD
	 MdAJHRsBy6vQerCFL1f3V2zE4iGnW/694jJOCw8ONem3NwhM3lF60lm4jtmGdWSEW
	 fFyZgDSQhuIj8xtWAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1xTSjr2Mom-00apGe; Tue, 28
 Jul 2026 11:08:55 +0200
Message-ID: <29ddfd49-58d3-459a-9bad-2466b754595c@web.de>
Date: Tue, 28 Jul 2026 11:08:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] media: redrat3: Error path leaves device in
 transmitting state
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1785158244.git.sean@mess.org>
 <d22b8dac679cc4b4713dd03875576d71305e3912.1785158244.git.sean@mess.org>
 <d59b23fd-0d97-471b-8af4-0379349829ce@web.de>
 <amhktjcUpSxHZNi4@extorris.mess.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <amhktjcUpSxHZNi4@extorris.mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SE8B+a3AvxfHJalOe4wMcoiN40CFh8/LKFJpyW4XvXUcbwJVSFk
 9/dSndaK6mLyRqzQA0x4rKlvtW6PDmwrFWLoWul1LpzLcHEi+TI7LFy40rsGoRjl3eWepwg
 KyreSWAntNy4S7VuqZjgC7FV/K5Gn/rPHGA+b/XTF6rptsgJr1O6zMpfS16ZWe0Oog+0RIv
 VQzZRauITrQMhx8g4Dcqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NQN8E0KCyxQ=;R1qQSbcrmS/riuPNiHJsOkhVmHo
 XWOYx46J6mQgBW9Qg2yDGU4JNbkIdICMul+avHHAX6B4ep6r7FeBbrJRfP2mfaGMPVV3SlSFt
 KcxXvtLWP2blb+v6gKju4TByre13zdq7VV64gVjFra2VFFRfhznXJVGBHo3EiHuNnoqqRDj1+
 7vJl69vWDlMP1BHsk4Plu5c79x4jS6iFTiiFbltDspHqDU9ix94XnDo/RjouEU2LG+sYcq8mP
 lmw0qebLATmXGZjuFztxj7NUe062ha+Nmlbdv8bGYQXLtBJ7/Nv2WUZa3Vce6hWFfIRMj0/JC
 RpIq/ijYRpm2QV7Hff1yyiT+Gh2Gg9i/JeoUSFn0tG1gaVhXmlARshNzUfC9cshln4EpiHgsR
 bY57cmIVs/sO6+nMyA3jMKdphotUYJFLkFpdODTaY6xTsQlyh183EgAogU/nru7+rkSjxemeY
 JoaTUUngzMW+m/rlbNd3C8UAnt6kZOcqd+Pbla8fCdVuKZUq40hX48GGI2kyageObmr6foKeC
 Y/NzA3e54Y2iStiNdWlX7OMlTKgbN+rvfH8FzKY+b32FSZScC2ISZ5f6/vFzeedcQKc9QwAze
 UD64m++CEsd91IlZnX9okV3ocUv1iv1mfS+etb0e243W7k9Dta3iEkgD2gDd2Yj58vaS97A3k
 ofI6KIhwnTRFD64tpAOrPhAIGKhaz5yhR83kYECZcmlTdn9VPxQI6cZ8i/6Io+UNXa3xV5lvg
 1RL35LRYunwOJvR9+Cuz6scvUPj8Wp4YhwiO0mqUfZ8BWOGwChkK4MecG5Kde1eav1oP1abxf
 APon6xL32tEDWCJP8Du/2M3amlmM9UVKYEnbvkTdg0xhCfILWHjtBWopbrwZfqGP08Ij9xIMT
 ImlknchNE1WfJsWLRSxt70YqDK0OCOtbx5Uombg6hSbquCjFths7oljHzv6iCFMnqiJ7xJNNB
 jjCb91x2gP6ryeXkfqNyJGOJ7ruBR9DkSh5PdggRr19/ByTHjCXNcrWDuY0y892GbpFSMe6ut
 vnks69qktLjBolDmMNSWJWfELIrQZXhbL2VxuoGpq3B4h3/DrFRaq7x8wZjeZQWzIDZBZv4rH
 HUGCPjXQSiB4n02FfpanC2wsg42X0ush1NKGGelvKz4kjdS6h9PDWd0Lpz9XAketpJQpHptx3
 o4pU5/a0j9PSce+kIJfuxVJUV0uj4JUNjwREbKzues1kqEz4PnGZJMd9F/18pfX0HSXfl5QMH
 YfcVueGJcFl7craOdDPJBMd/nMPuDtctvofIFtqGPrai55uGZNen+4dVts3Xoe2qoAgM3NQhp
 00nF44MV/uVJIAz0rBY9dnZkKFIlhRgURu2eTZp3mx+46ej+dpkxzEg0Y9+DjUkST+LoYo9CC
 VZ2d1APrMsVDcMI2nSY3tO8xQYbdP9M1pkXUGVlZz+PaT7RzZFLLHkZESs6T9QB9sLXD5yfjz
 9nmNZK9tj7qGvBj3XJP1iswPlklS1T70U2coKcURFSSc5xeriyAJPTj0CKnI3IYg3OXXc4ECF
 9Pne0QTb0DlZTW1iaU9FcH7QgZ1RUVV7w9x1zhlByjUPtnEGQGuuXQCm9piI8ciVW07L+1D7s
 y6wxkwT8YTeAKs9d2+IghYBCreBfMHq30G6rCuV6hc+fPLSCmAIwreviV8jfkMa24OCtoP06L
 0Bi4av7va3iJoU6QXRkccmcRsJETyPueS/OVO59of5U1r2L39A1yCElwCV1Wur61s3gAftg6y
 eXX28jnUaMEoz5gWxX70YO1T5dUpyPkSHjVODFL6ei2XGI0r0AHbj6J490ehkXMYVh+OFrBGn
 6FoGUJXiYjGdPNFnOZX80+QN5iV3YjWCt4RnzapNtOv6/RtbS3OjB6Tpa1Pmxr/ozLFWBrMdz
 cVeQIbWHbDNWdN32ozh2tQ8qoeo36a1vilR9TX5xJorCHnXusT95D0i9d+YcwYV4gVs4uiXmv
 LwIDE36W727yjMwHMPaFX5Mja7PsyzRJ4xijUeqipUgA1pzbV1iVJU9FLuAEvInekukmcH5PP
 yHMrtXrCK/FcVNr5O8F9kInAF1c1IWyQ68fZx2D0OGWTxGZdYuGd6BaRtiFM2iHKsaAhUzR8T
 21mDRQoTYaRfU+fPmHEKQwrzxwtMABk/p2Fy+pGRwge/UqrF5eDzA64HUJiFH0Un4lffeB33+
 gyVpLeULuHy7Uw1uKNpQmcjJ4VSS3q1Ba3v1gSctNmmQfXFTNDBDl1MeLLpfDLPdhtmRDTZPV
 9mgqrbEyZhH4HKleSnLsf/cR5HQINtGPO9kTQyCDewGOkukXwjgqTwb/loIfJvNRjmyJM5Nng
 9oYB/BECz3nGJM2IyGx4AP0jqKKJ1AeJCKMnw98jIcWVrAV3+LHRRsCHdNXhBtuJP/O2Dd9Yy
 FUbMt31jntXlDLTu/OVFjDG7OoXhfBDgQs+S3UK+4HejKlUy0P4OHfLGUNDPsUGdybKAwMYkK
 9Agu+eHNnS8jszqz1DCZWzLGV+2wph2pPsNtAjz61Dtzg7cSJpyT282ZXhgo8HK14uzYRASKW
 SiSliTkNV9kI0mF4RPE/JeUqODRZo7C7KDedlSxC1UiNw+swMBNfe4hycu3tD2D9cKMtI4Xhy
 7Uhl1gEPDaz52UazV6eRuRdXvrJFZhBdTSLceNRZi3JtpEzQr9P821edyrK+UpEdgD9oWeRag
 S26WPGfvdBnH+LLabXI5B9fJSIr4J9vQaKLZqWD3KyGVyA6IYIKLrC/jdfL+sJP/PAkLIZTvF
 YLFXGuMDoBnmX3X3tpNXVc+5+r6Jyw5xXIwWENaJ4fPRmZ4gKWXyo97fMRcwzTMpG5ixVmHAV
 LUq/4ojL7efaTGc9GiW3oEM/lBY1K1JZbhUdBZMJqu4c/v9GUCn7SH/lyCx/1JO3b52SHgN9u
 2eUzvl/ECciRvbRb2I1/5KcZf9AlJulsOedd2/FhGyw2eCmLekkCz+/mytt8SXL1mEJsDnENr
 Cld4dnkXCxz57MEn4xgd8U2R1ERX25X8dx941mmNhWF08l5cTTbZz2f+YfB5qv9WFelLsqrIn
 ivXDz/S8/bURFacktysm+jV00uKMnCztCcQ2S27Q5HJMnO3AheWzMlku5E33vWCv8/MhFsITw
 auJWoijoWrDu2bdkgYnGk/JvnWtksLFiwBbq/yBtBKeEcBk4v6fS6KOs09SAMgKOmxWQBWj5a
 aMmuH9M4LDDlZK3li9hdaCg2fMHktGSsIbd4rF1a4tp6H6bjshEHA0jjCzgtdZlzTLUaG6E2V
 rNUSmFpyoIxNUxYqDfG0Xe8s3Y20anFkQDCxY5drYx8HNR6d+6grQXMTaEHJVc3oBMhPep1KA
 0PI3REjEOOWXalgnzkT/MVlIZiBVeuOatxl6Am42cPp+D1Mwv5kyKaz9g5/vWgqeHHqbHxsZE
 u1wDREU4wNjBwmuNYgY651Hve5b8tq93OXo6YP1JvFKhAFRHxAlbLyOzXhezA/yvToxzQ02Gu
 pQoazLoWRf2yF6/9SykdSIguS4Uo5UQ9Ywey/raBQyD+W93oFQrW1mqWFKhsf3IM/I44u8wko
 HNpVXFGxkC2EfBzgFAsuiax7B2aWxrLhUlPDWvUgH11kw+8V5ytXnj1mn+bLAKuseIK4/sZCc
 Sqa1DnapMIqmsRrwrUXJpxQNBcKHmgQn4nx8g4Z4lrJtN/K+CmR4B2PyUx/Ckmlm8CSk1C4z+
 NO3o5vHrJ+TR7BIML65Vcbf2EXbsF4ro9U0xPYISFDVY7N5pFe9sdLwk0iHpQMMFnQIqusUcu
 pi4s30uOE9K5nL7QuMfqagTKluEZX9kW0unOz5pDLCcBpcd4uDkYxhrMs85T1xDSo4j2/q7nj
 fNW2/jesLkqnaSn1crf4RyFtWQpxIgpAmbiUXT1bPbEBs435A2ewRE4eWX6depbN6IpqkgMNZ
 +8KjhZdFEoY6tdFv+q5rWOa4E/GqkwzmTJtGEauUxD1WpL6ninDP7Fh00VtX1P4fnGyi8xvkA
 /v6Pb80ogbyS58JBqvEPwKVoPc37aAkAUY/88l5ags1JO93g71VlRkwtn6T0shp4mRnC0tZqU
 sZgZ1IPWN6JuiWO5A6kohkGy2ZeVWifNBnQuG9jJXUhpvdeKvke0OE70fj1dh9VD5FgbbIKgh
 qR/0McnR76vICmxYNSZVTELkylXxfK0sgy+C82IOX92rZ2l8qMbAGURMZoAxYlpMRHMzdWCdA
 OOrrst4EiZWdlyQ6ONWBbRuUMsDcF+04mA9pRL+2MVL4d2hcJeCxsXAyBVBWao+HeWwWO3oEh
 WbNDgX/G3Sf+LoqeQP1xaKlwljp7C8EWPQ6HXfmfpBuYbnbbdnr3TNpybqBEkSWzZTteldq39
 bZBKVtIKf90vMImfvO/whVJTK8EnbBikgS2ubUCzbm/ZkwyACFXuudruGMP7plEQiFRwA8/Oz
 6aKMTZyRQhZFRioZAuoefrs2sbxwACP/tFPC1MFuXsbPnKurM1UwZg7MVbMF2H4kgcQlZRrwU
 FLexaBPV4S+nymX0d6d6Z1zM4AvOH3ztau8G9A6j3kvp7WEOdDSrjhYPRoN1AJqig6VFi5ZL6
 aGLsJIrw2uNUiIt03zA/vDxMe7Rhy7W5eCDFVIV+gBzjOZCY7FwyteYcH6z0NA0Fkmg5JZ5Xb
 8WbtdEiA+sB7IrDRjdqTS0IjzVYLhy9VfRnRFyYIN/PdX5T91vG211MscfEWX38zup/SNMCMd
 26bJTUT+AbGWKO2i2eutW3DMQEQqWoSbfIFtmM9zMo2a9aVf1D5ME9wOPccv00kPby1np7vAf
 vSphCV+FjXjUcg7NH30dRRU307BgPSnmo9+OQX8P+AF3o3jt62he9n6pqrJqnniwU02CezaJd
 BVGoQzypMXv5bzRJXHeRPOJ7XVnRiv44Emjw6lqVsZpCPEbx4f3Bm7BKwNySLL6b50UlBMPhR
 8N+Kk2wa6VdYF0AMf6eksnDYkCe3B/7Rb8wx5CuTIyH0Fj+XOlcDajqpCbT551MWcD63pMClz
 8Bv63mKQrqq1pkWo38vchALlfQPVbrAk/L2izJhkzuSjgc22p+gS3ZiPmb4tjc0Bb5khchHHS
 s/QNq1i6UA/pktxKItPRnrRIAOehJEfhQe3qH5OGEIfh8kwK54WK9n6bDn9VEjWlVIeGYviei
 I5S3VNN7UJcQMwN4ykhNTK7GGb8YuHAv7Sskrx981AoJ22fwYbi/DKoMuWxynv2JK4VxvYZw9
 bede6O2c2oAxN+PSIqSsktdoPUd+DBsaTgL6KxpAeGGeEQoP0pOk4MkG3x256vfpQGlTO4R2W
 8gaMb0UcaXn8iFtseVcGS+mGpa7eUidfPo4shBqs0apY1xH2LQ6Ou7laYXDvPF0HA5c9QREjP
 5iM6l+fMu2c0pm7rOxkgNehVFtIJX32m+nobeOMTrG3jQLEVZrN4U7uwDVAfHN2crX1pTE0yQ
 jlviuBAWq1gG1hxj/HGVNbwXKqL+jrUpStNYFOD0IXXwclmvocnXvR+WD7MfzmBETJ04DGaJ6
 gXpd05SO5uhg29Pzswb+yqSFCTlMBCZW3m9SI+D5GjkKvaiHjRtvCCuEJKyQXRmximH7UTXQO
 +ZMHqM2SpjaA8TBPVgLD9m9cGvqEpSPHjPMgbTATruAlQfp2VPWLkdeuuABxLQ1bZiJYut49s
 fPLrjQ6jaCyP3DE9WKFRZ6Z5W68F6o7jLBg4QoELg744t4BP508wWFrlkjaQItTr00nCftXMb
 ueILsR28+eO2CYh9WZ3qaAJzj4j2y4Y1RL4qCYW/WB4gFb5L0CxdXAg9LK/a2LR1G4dvIbWLe
 rjhryEshcQQpdg69WH6KVpC/hm7+2gGAkwZr5rFXxCA==

>>> If the allocation fails, transmitting is left as true and the transmit=
ter
>>> cannot be used any more.
>>
>> See also once more:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv7.2-rc5#n94
>=20
> I've tried to re-write the message in imperative mood, but doesn't look
> any better. It can be improved though, how about:
>=20
> In the allocation failure error path, the transmitting boolean is not
> cleared and the transmitter cannot be used until the device is unplugged
> or the module reloaded.
>=20
> Is that better?

Not really according to known wording requirements.

* Which allocation would have failed here?

* How do you think about to add a wording like the following to the introd=
uction paragraph?

  Thus move an assignment statement.


> (I don't think we need a v5 just for a change of the commit message befo=
re
> commit.)
>=20
>> =E2=80=A6
>>> ---
>>>  drivers/media/rc/redrat3.c | 6 +++---=E2=80=A6
>>
>> Some contributors would appreciate patch version descriptions.
>> https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+=
previously+submitted+patch%22
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv7.2-rc5#n310
>=20
> This patch has not changed since earlier versions.
Can the running patch review trigger further extensions for the changelog =
(in the cover letter)?
https://lore.kernel.org/linux-media/cover.1785158244.git.sean@mess.org/

Regards,
Markus
