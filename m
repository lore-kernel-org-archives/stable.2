Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BE3002DC;
	Fri, 17 Jul 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276149; cv=none; b=e8TaQJejCNCVIROy/8hcOZqEfXN1aA/wUbzNrOvmX7YCqovF2jtz2u+jWGZ3FNGzClQ0hr3sgP9BZs5JoDMk5UypS4cQNg0iEHkXFMoP9EU8W7nfQuHC9ydx+ZLKk7mGbcAxXrAMpLj+PhtHWIvWfzUcr0P4wmdy0Ges8tkJWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276149; c=relaxed/simple;
	bh=GbB/VKmKrO0bVvKbM+2E6G5qtiIuFuhguFIXPM5nHJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmME9tnO8EY6MoWRgArtvnpNfFAdYy58FH+37gh95khIZsrnsK7D2eQvngPSHCWBR5ymZjQSvPHAaqTX55cAbhy8/Gcure2DZHJK7Z0iXONYYK1Ugg5nYeqS7oVbhEt2zjfM01GEtcHsfjoauF3e9DB8zdMkHYnd41j1v6nfBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=MDsGvZ+z; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="MDsGvZ+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784276135; x=1784880935; i=smoch@web.de;
	bh=CLuw4SqcZi1lEKlD9DTjJE+cjzVv2f5SqYtEO7/zL04=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MDsGvZ+zgs6uYZlEuuxwI9xfavxxXdx53BjOjweyl3ouh7+prT1UR8Okm4Uqul24
	 M8uGQFQrr+6N8IigMPM5bQTyYC3J7f31NS+VsTuOHO2HitkmDeVs/iXChrhuxBDXb
	 PTrhxiFRTHK8iUiHhBtBsYDqo6A0hU0aexgmvjdRGisM1d76Ctr4Iva8HpqHY/f/I
	 3p+Pv3Y36zOWYOaINcPhXJEVJoIZ4gvm4mfFOiAnVgwxclEMYuaQzK1ruLcHJvJxk
	 bFFEf5/hzDnM2glrhxZPgkidVinrIXkWsnwT7IJc3RBeWY6d/aFkTWiqUooYS6nmX
	 3uURABqwhFGWY+Eqww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJnX-1wmYbW10gL-00566c; Fri, 17
 Jul 2026 10:15:35 +0200
Message-ID: <8cb386d1-32b4-486f-a2b9-86cf9d46a3e8@web.de>
Date: Fri, 17 Jul 2026 10:15:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: imx6: Keep i.MX6Q Root Port MSI capability with
 iMSI-RX to work around hardware bug
To: hongxing.zhu@oss.nxp.com, frank.li@nxp.com, l.stach@pengutronix.de,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>
References: <20260717033203.2965045-1-hongxing.zhu@oss.nxp.com>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20260717033203.2965045-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LUKVP4XMMHrPv8SLWRbxJn+jn8rRVrD7hIU2qpLlUwnarsij/Yh
 /ARg8XGPf+r5aNfHWYSUtfvgJNAWPYinoF/CmqXeauR0+sU5mVWbnFDJiXV2+OAvOumeyV0
 yt/6bhRyPeV2yQR1SiERvQmwxoMF0Xt7FcesstI9NNDcQFtIMy+24bHUeaTMlXL06mePENw
 CRpbim0gTxCmq9pvVW6cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XStvjyGwY0k=;wut3CobyPf5ogBZFdd9+n2EqSMv
 Xil7kfFcSUfEHfkLorSSbjDvUr7ry/EkfaVSt/OimDpmX8mQGdON6k+Lbbgsq9JhVBrrm9ktb
 u874PVv4VMVWOKPfPSuVZ/qGLxO9Er5oL+pf0Dd376taFgNlrx7LpJX4mInMjP8AfzyUrdGWT
 WuTOPFuClkWPE4P4pw4ZTUKyluj+Ouk0lfjGEMt2b06fXjhsp3dn/Y+YtlEGNyjXdd6V0n7/B
 BGxzpoFNHN0TZoVFACBHY/d0qGrnyVb83uQ9plbDk3NnU70h9E+WN1qiArORa1ZdqNJiYlzlK
 mR0+PLvLpTqZUWZvy59VAbbqH0Lq4PDH/az+kkvp3NcSbkcegOgiASrOizgmer+co2R0byWIZ
 9WH6HKDCNEfflTNgW2PTa15vxA4PA+RhftxMyVVD4N/pqcsScKfCdFu5TJNBhlbWVOrbEbFDl
 xrNv+pGd+iKX9e3qOmuCs86bBN1NzoXopFh31IpoRADq+LDDMNQnTEjr7cb/qkW5936pDB3R6
 WbTz7KSX1EIuf38UoD96fhhGhtO/74G3hpKl/NymBSQupiXPQY9dTDM3K5nHfJt6SO7WtWnkb
 h/5fBFIegdJ+bMijpPPbzDuxOzvYNlvsMd0mhw+IxT9NEFPsPiFI5RxwWcRuJdkRZt7zq1B8N
 nSqyciG9wXbv9ZhWO5MPv2DGdMXoS52stz0w2P5SricBeot1j9rTDv7f76C6+nmKCnn8YyWc6
 9ZKg3nxdvNA5PE8K69HvAEw0dHozaNhkAHehon1YY2Zfxnl7lFBrGFBofhno0FBjyo6QT/xCz
 4B+WGL5Ksgldxd6V+FMaedGZrFsQItx5BW8UPvnnGQFWMaRYaPEuSe2fSmDqXyYTLhSTVI/R3
 Jb6Z579zR3V8asjZt7BSwYdKY2JM935j+xvllH1AWECFMVjX78dnuVOP3WPkL5E4v79FYnuKD
 m/BtpENMRNTJGYETcGdM4N7/RCGHX2ZR9V5HZG/ZRgERhThiaSFAeEjctakxCSDrCyhNOcgRG
 mNVPTv8Os87HRTPiUcKtAyTZgevsVAgr1mTk0OmAgHEnzKcM+yxRrYLVmL55kNEb5AnNMi+zH
 me5pDN+bIIjHvby7MDCQPJm9ARAlG7PT/7xqQbnuBdHv6EBiMkvasEQk8iH9/K/YwgIXDEOwd
 9bC3py4I76qDgSYZYDC/gDuH4Wa/zF7UxQfnbOW9lvyC3c+cC6VNcvjPSAasmNpK4NFlBsDdL
 W5tHaA+MBcqOyuzA1YbAp1xP+62DYQeQOhhq7LYBLnubsjKBstjOO+iCAj1ljLSCOGSSKFmXL
 dEQwwEbqHLEVgW6R5RPFG3MGlUb2bvqALr6FjAkwmgNYbuPuk/X7v7HmbwZEYTIUkqUTVNYZE
 ALF0Iz98EPLQtZp4leYT0JR5hdrM5y6zynHL9Ws3ELBZ75qFhuo/b4XWfVH3zEV/dLI0XYgqv
 4C3wCkvub22x2cGsKgeJRvg1VWH1s7MKqOxPc5FXMTr4t3/azL09421s1s1PcSkvMe2jyOXWV
 zkFJYNeFOE5Z7URWohUOARcPpL3P4sUVfmFB2j8K2I94rIjnB1lrVcxEgR1+vyJgi5/3Jl7M0
 2TElE2vEu3Yn7Ik4eMydQSQt7NU35JtsOIoqh0cUfqXOjcQHyU2wVsV+HlbHZ19bwvBaIt4FW
 xXPjHZUqR2TXEeNIHFIYA/pkiFe+bP4N/twTAKeT6hwTCcFvj0uiqkKLc7xnXWt6I5x8wD3jY
 cnpkJNAadWLhEoQfCbdIBpbCZ1Ar+xHeW8C2FFeHwo10hds7gvwSiMc5TydwoxjalN6I1cPkY
 EQUeY6HsgH9ZEJ3GRlfNBRctA+7SPOK02nSFVcn3r1eT5+XjZ8lPDcVNtGbcfi+UtnnofqZcE
 gtCXMR+j/QsRXG0GKyE6xVHP+q1hx2eK+NpOWHNWZMIHFaJstXEfcoOd1uHiAwO3trZ91zt6y
 EBf50AuY5Vd2IvXStLjXY8p3A1QZVzmtafnt/Xio7ybb2CZYYk19hd+c724FRDAZWPGp9ybYP
 yeE3gJcNXsPOMX+tfUqtBuNUAh5KqV2c1+kIRQyBs6Ujpd4thcQ/p+nzkxNTEHxYogXy4u+u7
 VWutcwBJ9WPDCIbJC+kXvRaK8B3Xs0pEGatLBsm7D5QgNbZKsiEFNvcxj4RnxzOTPbdwcoE0W
 L6h66cLt5t9FugZ0KoiwYO5aj8hWPfj11VeW7pacGI//7VIdu7B6LTYn/Tf7JVF8T/CblxqbM
 HD9wfK5P0hpiTYTOruO4bkw3bqLwBB1ejoW8AZStNodPq0eRVdDd7JXQSu71ed8Nib83y5dGo
 KAADiFo9L0XFuNsB5L6H6p0J3+qe2im+4sqi6dMeLXiauPcKjmNslCyAged3AgadGCnEDfWNw
 HnrGnpdX+WnQcGWdZbNtPOmj/OhIyfrM2x3UlkQruIlweixpCtzBgzR6nR7Ywauxti8IKUWoj
 fGrJvKqIJcvbO9YTL/D0tAE9fKFtIKy7EaR5P4pTpuD8nNCJmK0vmBiKZK6VK/XflMSj9/knt
 9FQrItegRMyTfsD1ctrnIeTSmmrIxMMGAM9M+5ZGoaHtsotNwrpc9KVQ+ieTScCjCoAvc704P
 mi0n7ui1Zdb3e6t4hE8kmHlGLiAMTZG5itf7++kDSTMDU4vZRcmMe6elKxc90x1r1uyVWUuKD
 2dABmL6Habd0hBXgAQoMgo/Nh3FJJ8USofkamRJc4/hTG/0IQddJfLFLEtvqJbwnoxd1UpeGS
 1vkk6TiknF8dVBtfUOlwbzCi6g6YYATjIedi0RWfJnAQFpFl902eO6g9bDtcpzrKcbWdM3qC2
 TEzx/Oe/SSMruW3e0BiC/XXM21Z/UO3+o4OudgsG1xQJzYbD4CM9sD1cydew0tPa7/rGgmzWs
 aJqf9POxKH8YzyrFhyFFdg80PJrXOqSMWEsuead2NOL9JVvk+1zTEPQxE8FQclz9t1V3fsyc9
 TO/xA6sRK99bopsC+Hh8R6pchkIyLR3zJ3SkZBI80Nw1aMVCRQRhE8bUuz66uB4hZj9PAVXAl
 PUMcY2JkrRwrEjLq+O/KJVUu8r2rVlccS0XUYKOT1x8poh5eBMPRZJ7ElkV9gHE6PejRgEcbp
 mTy41Ji04Ko4Oag9NZ9mpkKacSu3imEmu4fp7i5D8NSJMyC2MNOxQyGJkC67yJc6rt9rEFsio
 1/3jureZtkGnY5hVACEAZ8f03RNPmAw9BeaF98LrAwwj8yMKU86J9sfHBfz0xWTMK8zqIXrI4
 r01kl9Iumt2wTPUJeKLsXCE06pKh8VG5smKN20RE0KxpirnfoWRRmHkMwjzTSAwyU4OSwY4rK
 vZjLG59HITeBiwrV0DDlmq/LXvtz/NPO0T/PYoxDKRQ3tLJ5Q9oQFUttbi1lunwFZwF/cD/uU
 6U0cc0PpoAZbvG9vDU5RuIdudJwQ3X4KYGKXFqw1bGfPyBqXiGIIVrNci2VE0vTAp6bHuGScC
 gCcApjBPHgWzWQ15+vfMuaP2apUxtyPsAEUiSow4tapygAg449MOUvo1S5DYhQ9C9css9wsAA
 No3nqFrw/QaAkumdIoF9yP2qiMZB0yjI/J9T08F3lO4oEC0sUM99KjEpEU8pHDtxDraE6xj6O
 +u4d4OTUDCkedJTdtNA9tNfiH5NIZn8UEoN1v5EpKfO5QCNNowVfMe/HO3hyHyiBEJW7LXeVL
 oDEZO/1ntNzK3a9+xU4qR4I86A+OhUQXslN2sgy5/PEhi5bGDojvZh5eezWBgAPnVBuvNf8YL
 g51/15UNCQGOmrYC952LqPpDPuSpmEhrqMWprr4JzizRuiVbvQyp79EkddT7/7uqMKS2mRO+8
 RVo5Pu033JhmkKHkXUzfGBUYOmX7f1dSN9nRp2wk4de0hSHFmuaWTrHw22RQZlTLBTTg3OJ+b
 GA80VRKFJa7HZOz2dGR07gpCT3Udt5Kv2YwVEBwFSbtcbDQ+8hkDJJilBZxdJNI0LYtMvhLGx
 k5OaYg8oL5bfAjXVuq0zfchfIxRY7ERiIIuZUnaXLgXZ54klz7yXI9Vjr3T+5NMGqWWeUT2vZ
 Dst+Xgg5/imb4glF1AUsnd3glw3qoCIXbU241mVV/WHjJ3WvRJ3KIdq7e/Sm0/mADTL86rpRE
 RZHT6s7q1c2L3gr5uvhrPNfVAUW2q6CuxyaII3Byv4oANwVynXdcVLX+QdS/r9ACcM5TnNeDo
 CbU+eZI/g2f5Ulj79YAHRkenmhiNiZmzA+F5loK+9DZ8wV4EQfOhia+Bup8LPXz7dcDojHDK9
 S9Bwu5i4Xl/a9WEJfwmImP7cqGcY1rQM3B9/gEkwNKg3iG3ME9B377y/Wv1SeAmzEGeFOyVtx
 gqKhzvlOm1xJd746ps6qhD5qMy+uesQvCELFjqZjMoKt9bn5WpZRnBTRNwpWM5OYotBOFl8ul
 2Qq+Fk0ybdqhE8t+JqOuBQ5dFtPq6XluPo9MAPJskhf8CtWHlNOciMjrllmigM80vY9PTjwT3
 bb3XGFKjQg3FAvD6KY5GgDg0zGb5Ey/bhxRU4jkgbSbyC5VxxZC3D7WQymqDWPGJR5qAV2ZkN
 qimBZ8Xmzy3Ezi/FGzm9lwvPknzfZ/4oIKvTvmuDbXGYWI1GsvjW8gGuZ3l2YlYRE3xfCvJWw
 ImwIy2i7WBTI7yIXzRSN4k92Vs6emxuNp9ye/SqVjZ6wG7byfpCbQCX1TXqyhepjX42F/9uQR
 Vsya6NuOG0vrMkCP9xpEW/VSZ17Kc+8r3exK+4dOWsfn4bxf8RSOk7aKkbsxzUhT8SslvPVL+
 1f59yQ9IWGR4/5+u/vs1tLftIXXZU1vBi/tmcfBaninftRGHKJC0eUbPIckXgPlhKmiVM+6ea
 bCRqBbyqrGuFK4F680y+sz0g6cYZuFSs8O+ZhY1ZTloVw93g4LJd3v4DCe1eJcEh6lhxyhjEL
 zTySvd/N4RiNCfu4U9FtK7sC5WGTiWsXpIIzrYe22DbGdsji/A15SteDhG58SsnF3c7ff9mSr
 DLUgvIc3oO3wQ9m9H0FO8SAYF8ays2DvaztptpGhbYoJ4UaiRhVuD48cTqi2BfrE3K9R2LSrD
 A59RXKQxm5cawEerG73Hkz3BVjN7GTSCZXmUg7UxJiG/eJummCRsfoYxBjt1iHo2C/0Fjv2b1
 D6LUjq2mRS7IAI1KUmG/E0/MH0zuVedUK6PlIk6jcVk44Nplr5pA0WAy83KTurAACDBhg6s/R
 /qybZWyg/4fq/gTItUpIyp6XweJWAUGKex2ilOhrVQUyYNMM4cFxaOfKSbegH/e2aXGKtGpKx
 wrFy0zik5CGfdhtVNl2t8qcfGpndmIoFuspm40jrSNQPa0rJUfOiRPTdxqMTjZVjT3tpT+oM2
 o+kJNaufTX0MFpKe3yj0seWE7TQ8nL6aApcc1RPYv4+eATl2QcsM/x0pnXUqZ/bxtAvxpYTlT
 rVMKa2yG6pEnfWMYK0Hz75D6gTkAZhMa1vuzwDfW42j9P7MllYOQp9sMGsk+yyqHqylYRuuYb
 SVli9kodqRoNvsi8lwRKG2EPkt1yAC/In9JC1X5npv/k+4MwtMM3R49CJpfO5MmHM4ONgrPjB
 j4HF7y9RCZtq4dwcpp3nkCKytEtt7Kl3vozKjrNn06eXMpJl0b4d+QCSnwD8VZXyaMlYaMkho
 8bD/wSPeGuvhU5TXxAT/9Zl+fN+a2q97A6BZ+j6ueOX+7d72wy3fui9ByNPMhDbZD0BMyXBkV
 JcxXDdzXEEJL9NJyOLAyZAQHZq51O24xrC8SIIG6v1rEnU6AAs8CU6JVrTNLrA7bXrNURVejt
 NrBpkGmG/ddFxvrDl9WZUu1r2pXopFTJBb2QTXl17y2XxAh95uWJdDwUoFvgoXKav45t8GcVy
 vtl/mqqNFslZ6Fnl+FFd0yErN/6DATVVA4TO64QCqv3IH06JsNsYWfuM90qeyPmScw/FnxJTE
 3Fw

On 17.07.26 05:32, hongxing.zhu@oss.nxp.com wrote:
> From: Soeren Moch <smoch@web.de>
>
> On some NXP chipsets, disabling Root Port MSI/MSI-X Capabilities blocks
> MSIs originating from Endpoints from reaching the iMSI-RX controller.
>
> To address this hardware bug, commit 3a4e8302e72f ("PCI: imx6: Keep Root
> Port MSI capability with iMSI-RX to work around hardware bug") preserves
> Root Port MSI and MSI-X Capabilities on i.MX7D, i.MX8MM, and i.MX8MQ
> when iMSI-RX is in use.
>
> The same applies to i.MX6Q, i.MX6QP and i.MX6SX. So preserve Root Port
> MSI/MSI-X Capabilities there as well.
>
> Note that preserving these Capabilities means Root Port-originated MSIs
> such as AER and PME won't be received due to separate hardware limitatio=
ns.
> Users may need to use workarounds such as passing the 'pcie_pme=3Dnomsi'
> command-line parameter.
>
> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Por=
t if iMSI-RX is used as MSI controller")
> Cc: <stable@vger.kernel.org> # 7.0+
> Signed-off-by: Soeren Moch <smoch@web.de>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> changes in v3:
> - Extend the fix to i.MX6QP and i.MX6SX variants as well.
> - Update the commit descriptions suggested by Bjorn.
Thanks Richard for checking 6QP and 6SX platforms and extending the fix=20
for them.

Soeren
>
> changes in v2:
> - collect a-b and r-b tags
> - use correct fixes tag (Manivannan)
>    (reference commit that introduced the bug, not the incomplete fix)
> ---
>   drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/control=
ler/dwc/pci-imx6.c
> index 98e1db751132a..dba27eac6bff6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1995,7 +1995,8 @@ static const struct imx_pcie_drvdata drvdata[] =3D=
 {
>   		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
>   			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>   			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>   		.dbi_length =3D 0x200,
>   		.gpr =3D "fsl,imx6q-iomuxc-gpr",
>   		.ltssm_off =3D IOMUXC_GPR12,
> @@ -2011,7 +2012,8 @@ static const struct imx_pcie_drvdata drvdata[] =3D=
 {
>   		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
>   			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>   			 IMX_PCIE_FLAG_SKIP_L23_READY |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>   		.gpr =3D "fsl,imx6q-iomuxc-gpr",
>   		.ltssm_off =3D IOMUXC_GPR12,
>   		.ltssm_mask =3D IMX6Q_GPR12_PCIE_CTL_2,
> @@ -2026,7 +2028,8 @@ static const struct imx_pcie_drvdata drvdata[] =3D=
 {
>   		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
>   			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>   			 IMX_PCIE_FLAG_SKIP_L23_READY |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>   		.dbi_length =3D 0x200,
>   		.gpr =3D "fsl,imx6q-iomuxc-gpr",
>   		.ltssm_off =3D IOMUXC_GPR12,

