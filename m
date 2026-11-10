Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325866;
	b=4Y1BNC2aShVo759lrHPgkycgP/E6HjceePUGOqBUuLwkG8D36+L/J54MbDHg2Rba2dMw
	 fA4p8enrMPQfrUhNKMi1DTOnuBPrILpkhZTdyCoZCvzfPTCQtCWDrSMLVrz+8kUqGZ8KY
	 3W2EcO9yxXlENMrpo3Mx+JCnbGOBQN6NT4h+2BjH+RZM9thUReHDxi1aRjD7VQYLLGAjI
	 k9Vkwe9EQ6KEiQCOR52pSc8/lmv7zDb6couSAguRwU5LP/RaZBmKIYFJP5kxjlCkmNU0G
	 RvXh0aXBYLOGeU3M0F9e9wjOKbOgDHLlq2bRqgJNJKUZ52sh0VCFAx/3ZqCTZ5u5Lwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325866;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=8oOoPZ2inaQp469WqkgzPu88gcv8m07yA22sCBbEfDM=;
	b=vWSuRG6hHvRIE8eW8u8zEoX8XCnRXVsCeY1/juRCDYKcB76lYpZxSyNFLfTuZ5/vKqwZ
	 nKobnY7Q2fg1DicWAwINP61dU2ak8noZXowiOVFLJ+WNaqIufP6Pq4U6QB0pOx6ZO7Dtt
	 6rQbfWOYUzJEU+7Z7w2YB1BsY/KmdLFuKOYX6wbgmPMAIEpyllVkTHfU4vqDoUX3NiXNS
	 qPAlPWAW2aPPF+h1PskyBkIN6D33GJENz/brtFQ56saTAY00UwTgBMkmUY9704ncsz5c5
	 y2vnl3LkmNgiTLjFOSUpp6ZJYziIEpMhy8Azxuwz3+HDDHYJq6YbmjnCt7qXd0+lYMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="CE/imlzB";
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8049606A31C;
	Tue, 10 Nov 2026 15:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8049606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=CE/imlzB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794325858; x=1794930658; i=w_armin@gmx.de;
	bh=8oOoPZ2inaQp469WqkgzPu88gcv8m07yA22sCBbEfDM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CE/imlzBYIcfmSOOJktNHGiE/Dq5Utk3pSKtXgYijuYMroNBuk1nrXWXdHnA/lV7
	 rNKzJrrsImVAqg+nv1n1UKcfTEwRdcCneUerREm+5/xnnCOco6fSZmMXQ9MF0Iv1A
	 cUMFtJnHAdqpcVrSqG13MkQ6iej7SfkWHoeeKi2rYXZk4mPzceSeNlYlN/tSUCKbe
	 A11ol/T15FoQix+WPeEX2AblSbFJI9P40CPyBU48Tu/tR3YFstm5gLP8pfnr7dTy2
	 lca2yy+c3rqvnaMY1JTFUcqm7p4a6FzNSbGfiIBPD3ua20f6JRohfeh8jQAqKXSE8
	 6ZOKAjZqVxkIoxwQXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1xHyPy38L2-00GM7l; Tue, 10
 Nov 2026 16:50:58 +0100
Message-ID: <1969fb5a-38ef-4b4b-9d2f-cb9a4348b968@gmx.de>
Date: Tue, 10 Nov 2026 16:50:57 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jorge.lopez2@hp.com, hansg@kernel.org, Muhammad Bilal <meatuni001@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, linux@weissschuh.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261026051740.88791-1-meatuni001@gmail.com>
 <179425317709.10927.8604237354153885108.b4-ty@b4>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <179425317709.10927.8604237354153885108.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7yMfWgckZ3HwbywMKlvzv1DjgHe8cBwZCXDr1pL5WPcxuaiyi1f
 9+39/IyP1bA6uUBiYNJ35l0m5eKGJCGoon4cbNozpzf/Or6rNG9RMHoLcuWkq+rbTj8vEAG
 NBleFEaJ2IMrveHm7jA9l2uoW+TWoDyR698cSeBBB60xV474Baady/gEA81EGGN54ewNLh6
 AOLh5ctnPm9OhfKCZfuAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Uguylh90OI=;yYsptzVJCmMCHpo3rSJLUPvzQ9x
 LER2iSAWdSiQvckdODh3OtmfIVDMV+bWrP4qMwtZoJmoBckKy0jAm76hPOPF22xCX+/gdJLMp
 NFB1sbmpdxn9uK45XDz6B9d51Gk0+fGH/Ku+A5RQlDOOwuZ7bzDHtecUP8UufrSksuy5WWkFf
 RIKT8IJMc5spzW3oGp3Y6skIdPm6tVpFlAa3CshcaSTkKThX2ZzeH1IL6NVNEIhiX3AqVjowF
 2EWJVveo6gUYzCyq29ASFjEm8XCP8FdEnrj3fYjUJe7AsOLOUXSgCsvAtYWtUjWp8rtMYvStf
 w5KEv7OPfCgtGTD0bn7pIxcdJ+mSzkUxXhl1ic1tN16EHmcrddCib88ilIhwIkDiaCWC2Obng
 JP07aHLUtnPHnPPc324eB3XJtRvUw4rfmlrBOwx6XbmTt75zDeH6vVbMUDV0OdlvnLwiC7TWV
 y/ELE/LUoyroAJ7oyoarAIKWSjf/MqjQGcoU80v8/D9OpMVpvqj5eQ8RqCroGR+//vL2HKqMV
 7jRNClN11Z4lGq2gBKL0NR6Utqbsy8yLnRzEn3x8eaxrAeYgx/LYOBQ/uc0HefgD3sd8tyARu
 nPiQNAzNEEghaUJcWVCnTwbE3uzKw3qRxr2xZPMTeqI9s3gxU9gALc3Imb5QCQufxsmSGs419
 Ic/N3jIX+ehfyK3exOKWgnRCe7VCQDT6EZOyX6ncg6Z5Ub6t/7hrlaRUIW2TEHOSvhIBMf1zk
 dQsorfUzZVfiy7M534YbnOeLupGzQyTpnCB+Qx2gmj7VvsZa4nrlJAG7gZl2EpNKhnhProFTn
 m5uYucgQPXdy7Jg5HAjQA9uQ1/yN+/vVEO8qnleCUByyxL43SHj9y7+BDANMLOKNz/a51SZ4Q
 WXD+aRjZXfY6Wus90HLMSrUx6nDAHJBnVcWtYX1fsCmmcpnapdEogH8ZeMS4ELZ5h3z87B1XW
 lWuFISIFrpjw2nrZehsFjPg716uo5hmGoZFayvgElMjXwR+wJqXIE7iTk37o02fynXrU6L/Ef
 usA3Tsn5kmLQ6FvfumN9RLKeihMl4lkeHRcXsdq0uV3ghO+6ou2qeXefEqPuUW8j9Q8+2dRfB
 BsU6282jlZcxbzIMGHEi1oVVAzDeB1Jh7Zwg9pH7o8Mycru+YO1GL03dvjH02piobVCiIjXhj
 iAd4dO6QgNNoIBnDu6YlnukdCtCo+bNd26B8QpVrmTs2j9l5SgzqOIiZOjLBWZco1SKrmOLBQ
 9g2tliljQg6Er/rXClmzmRqixvHdGz3EWBaCl6LW5/FqN21q4lEBoygtE6Md00JR3zcHr4Vho
 cdhA1bQvv6RDhH0c33ooBaJYgU/Qxdq+I2gQ+pSyRPSureCf/IqwRySNvWR/sOqRdmPJ0c1/k
 +Iq8ZDhJQpJzfmF2O8PxR0QcJsMBu9+e2IVLYObMG0nQkQGaXPjb64QNSv8+be74WxG5vhDg0
 7GPMiID6xa0z+juwyFgXw6oXunEDUCr10UF2bsul4DekGmv+TTO7i2HxYy7X0zTgajBLTO9Z+
 8fKMvApvM7i095xRN7yM9GIwUWLXYBIIcmdCWSC9RBb0S9wr6vgNs8VFwgfL9Y+qTpoa6POvd
 EHS24ihE5vtJnDPLpAX07jJvgrycS7+bqciaZZz5fniFEOZvMzt/hFrppTiRKl9DPvbhwllUF
 3I7BvPedONUwWSLSU2IXvYDLOv09qABtdXveLmoasw8vuigVBO/+iUlmUlUGWRmv6iUF2YuS7
 net7UILONuIPz+ht46t5PZrRoQwYpdbrg2gaDJqjE41p8CFV2hEyIZppD1o11p1d6FUKZf3ww
 BKEjiVs3xeACEdYIzvp9L3Cw9y/OpnV4j84KKyN+6HD0di/Dj/y2i/6jhQRcsglb4Bqimkqo0
 tcMldQ4xmruqIJHdRvaImMydS7sKgz4naLeY6chLdtFKHsOzFuTBVNjZqqtlnPKH2bdu5l0Vj
 Jg5jHqsumxXnyLvBIvZPirt4NoOInIP+kpExohHfgwZQ7710KIsvK640N9ujzo+cAqYJCgLrt
 n3eLkKZU+2NUVDyWe1iNUP0wyRUBt9hUv6H6U+GJbZE4SVPOOuxTAZht8ixgaVYmrnRYoHShg
 XH5z9Tjh8W2kHVoMe0Wyf8R0c3Ljr1ZqeK0e+I+tEbIJqMG+msIdyr4UTInB/VPXjau/RyGGA
 6uoD59h75xd//wmnxHyBB57oxGIvGNdiXOLrLsdwRt/RUT9RyxBIIIw4F/CelgAS6wdpiryyI
 N3uzxaayqrJW/rcOh+NoSuant+u5iP4C9ldxl/bzhZA3bLIj3G3M0ycRBYipnktEAZMDbcIx0
 zXph/ZeDuVYK5bl9mpizqP69sP7t5Bct/QabIHSJe5mpwQyMXAAzd5Vapnzuyh4hF4h3Shl4K
 6NBwkyq3JlzC5rCDzGSu+AMV/PkdV067Q5H0A49V38PgUqfj6ssXSZ9G3VDlb0F8SYfIJCKyy
 J08zYxN6R2ynzYbnhMnFl3zjTh90YkBPQl1FCaJu4kmp3kjH9vOzYlydVOWS6tcSEozpLifTt
 kaklgnX2V6isHg47WKMqoS2tsWPFtPdtk9DUZofsvCwZLeQZGWTHe5d8zHGphgrM0lONawaC8
 oaGfEzrUAlkMxR6l9hEPR8g2PNkmkGD1+3HpGeJcDEsBymWWB0EaBrhCdo2lBlPsGT0Us+Vxo
 JtZp9eduzyFPFfLEhOh9GRIWNrqLikzyqOwNrdrRCZO4MiDFxHvfygWUASJXRE/8CXxb9yXJI
 mU5YxDaKY4pNldLODIXlgRXySRuN0W/D9R5AkzZfw/Mrsc/na5z8ysgYQ63CKJdRXX/z5iYoi
 uLuYwSX/00FmEWnmT09TpEj9MOiLLGJ49XCULiP+hx8uMsJXyjmnmuk/nnZ2bYun/HXqM79lC
 6Boc0ZpIey24efciXXkhn6Ai2PEsar/3PtHfYYLdSDVnWguhNDAFHl216yaMqjis6f7oIbAAw
 H9jiarZx6Fvp58oBzN6xu9DNoVcgX77z2aBmMoTDnlQa834WKgMwVZ3WoO/V6x8u0+1NArbx3
 y/FkstuXqXsMpUgO2IMDfvmNP/tGNmXNVistDOgZ6ZdyBLpMc3ht/mZYichwR7YeJKjFHQ5z5
 99/NNTBP7hOJ+RmudW6h6+6y8qIP8EEs6hD3uje1kigYyH3G/h3tQHGX821tafiBrvOxH/mew
 Pnyi7oQYLwAQ4ireAghO9tDSrkiIgSJ9FUtkjqm/YVj1NXgmPUN+pNz7UIs+altJNekDXhakX
 0GTv9hY3zAR0+U8hb6dDuwFkmrPIBuJqzBY1/kkhdJQjnUJ9Elb9AEa9djB8qYJFf4g6KIn8h
 fzqsCj1av0WlLNKtK3bnTI5ftPDERbeJXR6BioYtBc+o2RtfEaaibg0QvBGE1eSk1lRYYo0DN
 zPAmCwA7iOIn3pUzw9zGtgi1ptInbovc+jYKN7lE/rU5U/JuZzoojjc9mgfNM7pZvkrujVlAC
 F1lfnUzOH5fuir2B4lz5PBeuRfPqwlPXc9X7PkvnDY+jxTmzvC8gb2vr8VetmS8wqJ9LR+2mc
 WJx1eVwb4zrESZ900Wr+fbUje7BpTOX1DfxCStwzdogI2zG+ar+FcWut3qtslcVHHk4wXnJdR
 xjJHTiefKYNzWpjk9vJ3AmFKgp0B/86mNifu+Urhdh8CMwakjcHfrSt1c2vdb0CXiztLu0+my
 VFHBFFycwkaa7abFJCDmOyf4XnKvLG+zNzXmokx7cIJpWWxRcqNCcL7Cp1a2I9dErjZo1s5iD
 HVPS6Z4vdwz27n08ijMrMPWp69MrIqIOTT425w3qz7FWogGwfXG+M6JTwfS1I1mQOVMsGMePs
 jZOk7fjqis5VS+g2N642vRQ16q+JLbudmnqNthRggQ0IqyH6IxvV9zqDvbdeyQt6/BYJ5MkXw
 vhQsqw0fEqQ38hMzXX3rSxEgdelCwQqk6Sk+LdVvXDECcrFBBgc1MD/vzq6NCkqMPGwjuIvTM
 W5MYXeBzQjx9C4r/a02Sy/56ZqksoQOjR+26HHTy7VSxpfvbKlyoBwz6WyjuhDdYX6DYVSq+H
 d4fmn+uevic6blb9jRrgM5FRArSyKHa0Y2q0IVzHbB7PAm0uKoVS4lqI1DEaZcwS/BckmBFCj
 HYwTTndu63KrMRxEosoheMA1MCmo/2S8F67KWl4/MW3QKipxkbzmH90hN/NI2DqwivuwKRkiN
 oGPv8pIBkCQOePvz9FXDQM+fzEwKGxX66AiZv08Uk6hEZdlz/SVe/ptUdIj9tCbfv7GkDb0RI
 mJ4s5fZjTp2zyqEYhTr9k6Cb93oHm2rXWPpTlUhzjKBYJbX8rUzoNpFlVbX9cd5gmxSUXJmXl
 fjPrzVeOXIcpsvqcOYUw72caLcTS3RuCgSyEPgerXrPFdWqqQ9MXm4vfraPt0NpF+QZCCKOeS
 qVD3UGFmuP0ymBhbDfVFsk00wjacgmg+pb0bMMGp1XEUUWMMWwRYBS1knzLXcPn9Ki8QJm5BY
 QQX03RyZVmJG+ydTUEwcdRUm+pA+osZRb0PSVD8V5ATu4bNr/xL7Cvo5xuwZS/4k4CMywjqsP
 M0iIzAv5Sb7WIfYuhW4deu25nzyc9Uf11VmOvY4DHeMZe/XAlHdM2/s+rxKwLXVbyUU8x1o0O
 yz0gCZE2wbFrs4tq8sy1y4P7v7uMvPaARSQMN/OKl/le9r7oUahQ85r6MfzJan1q2gMw6Q6ON
 6WtSJTliDHPlkS6YrQKrx06hDZyUexMiqoYgFxJiCq2k+ggjS+nFrXMZ2LbFChngvBc/KmCOG
 NK9p3RiLzRFDYWppwBt1ZIjLlKBpL7kz9hcVo5DJ8KZMYrNBhWXCTPP5o0RDAjvMe8W9PB4R2
 F9V3GMYySCpyKJfDGk/UUR5shybHtzA1DAT5H6MNd77YyrrBPjP9s1R4wHZjfZPITl06d3+mg
 VUC4/T4K4OB2Z+X7sWfcmKlKxV6aNuS0DRvhxRn54XQatOrKOd5YAlt5XOSpeAJkhcyw5z95n
 ++WFLIe1zw/nNbZ28Dh1rKlj2DFrodHwcWJ/N/sKoKXNovmXK+51JpAYMTwW8Ts6l8nM9HFlR
 sPg/ame1z0HrAkLGOW4T5Tv3/WvJ3gZ9kHIPA7cGDo/I9dnyLfBBxwC8VPHXUYDQhbwNH0aVX
 6pEhdwDMpw6Pm57Tty/l/CHzojMD+vokj05B8cdSxQfDmyzS3iBo75aZk6U/p+/eNCKa0IZ+R
 vbpMr9E+jR9ndtdNmtv7MXIiyoJ9Z626EJQEyYKheecsu/zeQhdPFHF2/cDVeeKu2HSXp0rxE
 wX1FEFuX8TV5Bx8SgWzfrQ+k2eM4T9uJhuJVOVCIXepJtq0KbD/8nfxOPvSd6EV3ZgB1fYYc+
 qAfnqeaiG+apIow4Gvn4iACAwZt2ozq1mCfdw7533FmU1F0531PMmZ0Qh3PNrVgZAKLM9nZKW
 IozVRZ0kfwFzdSc2ZpZjO3DY4DurCFGm+/zZ4/8ZDv8UCvnpvfP9ulCbAkxKucGZibYajK4uB
 tHHRJeRQwAHAwrZuK3IO47VBUURHsKkwddqDHMkn9G8nhHAoY9lnF/YOEDEZWoWcGig52CFeB
 C9z8EozDM2kIl0ord39RjbZDKDjvDN1jYPRrI8IeMueF8NaxkTU6pmBNqqTsoBtv/DqQbZm00
 kyiYlFQPCbo+NJov/Dqee/6Y4zrpSc+DtnT+mEuI7YlVwV8YXU9iVnaMRM+ZFGQX1q6RQqwYa
 Mrug4vX+vI/gj5yq2erxFdF7jreRJXXGMmjnNPDfzWlDgMW1lEfa27S3DZfa7QRTaByo4f2cU
 /gudnMz8PytM5oJ4EGMtorh0iVZvXWFghhWIH6bMLPKSEIlktVRAC43W6ADleK9kQxMDQj1v6
 E5yaFxwXZACzYAzHix+60V71ZgWGXGcKCQKtHwOAqTN5tWgyV+8Q5lCYJ9ZqLyDriJgJqdqEe
 PxR4fFyRWNMHPdXcKIi4j0rJSTqvPeG/4DRocd1jmAy/iYgaaWaUieu/2ZBJIpsVlvxFLukE+
 Ybi1f/WF3bwyo7HnSOU/4wiYpWldM7o/y77iAo+Zjpr1yA+VEMa1bQVy2cfCTZGTT2XVjjXSC
 1lqXnr+Tatgbr7pCIJX/xUXNMhaWDeVbQdfylZ8+d8D3rF9lA3mjshFyHnlHGYLAT4vO/RMti
 sxHjqyL4mNuuCdN/JV/JlfFdqa3DpD1TtH2ICIMijwL85bdRicHfOHFPMe5eOlYv3MnigS0vR
 RezfkM39Tfs58u+LFbAHj85Qclr9zNEg1aNPeFNVeKQ1D4s6/Pt0cx0qr+7/7Tyx8+MRbDH/y
 4at39ZNCaST6dyVsl+DNkeXU8uMiRZZQB62Fv67IHORDaB4R6ByPk53XxZgMstLaoDAg25c4h
 dcSorEdShIdi/zuBUhMHrJxTIE/qHCcF94qFIxVGMaJyldq+374V8zlJkXx+j4Mdh114EPWiy
 GJl9pb8Q+c8q+ho6C/WzGyJXKrJu2wW3gcjXDhorq5iLhJswiKHZDXTTj1diMnxv92wmCRrZp
 xUQwfOyDnqVDgwnXlniyGPqe0iwWGcs4TPPPMlT74kiY5f9RbhoHe9+UK1OkZFlg4/JSgy50F
 mq66OYyqoc9RbeRtUIzNXhEPUIef/AfUTRj4Z62+w1HVf8hlj9lZ77NTxtPkJzvQZFDFaRdIX
 ufWDhDa4cCX2EM2pmXsMHzS3eyOyAl4eCIbR63cRhvPqDTkf07d7G3LyhHSSBSkBbeD+k0/Xj
 51K9EfYoV7m/tQVWO1pWJFaaFDTTpUnSEv5aXzxFyaivGPnb1kJo5zt5XOUnAhpBw0sAe5D6Y
 sdlCjBBJ4tnSOhXEov1olZysqUk8CkpLaDJ8wnOENVyKD+Ct9nqJCp6lApB+/WUSdznNUqvgO
 /SYLUHnz1ye1FftB2d561zlayFNRpwwWnpg8J5X2BOuX++iQWidVJ2a8rrOcsWSfll0n76yk7
 5vsuW+U8UdWhj2iBoU8YK3SYfh1B1bqpdOeu7rU2eFqQZdIVu1P75GCtt+y5X1aMrInYfXkxt
 KK9Vj/VhtpVQ7ZuAW9PKXoPitULJLin3jgKH4hRqG4d6Cb8UTA3EL5x0Md3s9Qj5lgKix/xTo
 VDp5MvCd0NvhQqBbZ+av15cqtDg/oTNpJunOFzkssTcS01GCaxOHxld+9E4uMwmYGqsPVC3Ys
 ivZa7B8GDn/z36iVmZbaFxJz+A/b69trmUYRMg9UpkGlJfK1SY3r6IidnYR2Dry1s2jIRk8cH
 OcTO/uaZW162D7+4Xjcmv5CCUyyHPKR13W+MO7fU/wgJ1A2LYwjRurlNdEetBOhw7jPch5Y/h
 1oucxDmPQSD9udj2esZmYQv1GK+1LTtPJG7v+s1FvwhWuxiP10xGe6SoSDb1OFLl2Nel8RXk4
 ckM+SZVStadBra6DsDTuF0YKlAUGAUmQPgbdzBd6mRGNaREk9Ltp3lD2hj19/oqGTM6bmoR9n
 D0mfjGV135h4kzfRUwkTE8K5X6GKc3M7eTH/6rnDofQAvwI5mNvYOtG6MdvO5cAQwwv42yQK5
 f8t5m2y0PvD13w7DktH+zW+j/w5lJACzAVG9qjkwIanaeIzJzIgjdrXhqAYYiVPjxY5bKboVn
 GWyI18miiw==

Am 09.11.26 um 20:39 schrieb Ilpo J=C3=A4rvinen:
> On Mon, 26 Oct 2026 10:17:40 +0500, Muhammad Bilal wrote:
>=20
>> The input is copied with kstrdup(), which stops at the first NUL, but
>> the full write size is passed to hp_enforce_single_line_input(). With
>> an embedded NUL the helper reads, and can write one byte, past the
>> copy. Use strnchrnul() so the scan stops at the first NUL, and return
>> -EINVAL for a NUL or newline before the last byte.
>>
>> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
>> followed by 4093 bytes of "B" to current_password 100 times returns
>> -EINVAL every time, without reading into the heap.
>>
>> [...]
>=20
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.

This commit now causes build errors on for-next because strnchrnul() is=20
not exported using EXPORT_SYMBOL().

Thanks,
Armin Wolf

> FYI [if applicable to your patch], as per Linus' policy change, also
> fixes are mostly routed through for-next unless the fix is for a
> commit introduced in the most recent cycle or is clearly a regression
> fix.
>=20
> The list of commits applied:
> [1/1] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_i=
nput()
>        commit: e7cf4282a8694f14eb44a2f110c7628a161e9692
>=20
> --
>   i.
>=20
>=20

