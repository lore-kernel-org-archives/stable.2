Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030781;
	b=IyBMDNtALk5isu+9kFsV61Tzeu8zzUFoRZVGEy7z3zJKVuEjjW0YulKIhe5RVqcPHqN4
	 GRhC+WRsauTB1XcE3ROKcFxZMsDI4d0p1Iwvo6OrpO26P0VOeeEwpangbpHXCeYCqJAJo
	 wmXy1xt/lZWE8VXwiCkyDu3HP2kPwwzhAa1i7UmjTRlHdON/KhPP5mWrf/HML+0OWOINW
	 hpIRo2trVFAFREbzXenMPpHQOPW2c2igF7ehDd60KFU6FtNAAawkhUtyUrkWBzOUxHdYo
	 3hv+Z+n4NZh93yNm2M3IeFJZW1Zf+IAM6Z7xMrkIBd3XFypu0C9TpPZqy6jSfYONgpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030781;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=/naHj4SZvnH4cSzS/OqrV73Lux5lB16W7/5v4iPmDGQ=;
	b=AyVl0Nme1BU80cgBnmbRr30i+Ej/zzISIKe+/05a+IR3bc6CgcRjEimoCeArpX5m86/3
	 228vdQwRkW4egtV/132ftFp4MDoqIPHjRVWMCJGDoAR5bI8tBb5YUsN4W/yCbS8ienIzt
	 trCKSwv+WY7MYeXjwARedkQU4IxADy/UKTwbtlnom6XFoP8AuyY9Q9tFMf54dEUcn22OE
	 y2ZmAL3A5qsT4Sb8gkHItpuyzemTyBCdFRA7R2JRXuREhYIYiMEeh54vvuxyfHTjwr9QW
	 UHRS3+hTROu8NX687w3f0ixPRpx7mBzU8by562Edjd2CzNEHfqrvdA7YCGZ00pQbwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VsGa+6P2;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C4606A31D;
	Mon, 26 Oct 2026 16:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913C4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VsGa+6P2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793030778; x=1793635578; i=deller@gmx.de;
	bh=/naHj4SZvnH4cSzS/OqrV73Lux5lB16W7/5v4iPmDGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VsGa+6P2HSNOtYLSpZccYEcfZQE2mi106UJF1uhJkeF9NZOYFZ+jlOo3XliYeA6f
	 uBULzm9uf/mM+bgvKqIp7iN5CT71HfTyRCIX8XVvx0UOti+eEmhKD8gCwqSryfC7Q
	 fhbpXwEcOoDZfZaKDE2KOva/7ok8b7JMiwbj2kv9P8lFgBbIpGXzaqh3cX9O4Gpgc
	 6FuUHC0Sn92o9wINqKkB4+gk5WqBK8m4DUi+hK8z5VaHoZxt5/B0SNjR6TJUMi/kS
	 muZM/+xx0bh0FzhnKzNPXCADWlXCaqJMwtU8729hSTifSj1fdn0AjazXT4MhBm/OF
	 8mHAK6+aL1cBSgTEJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1x8LA50wQx-00LvyN; Mon, 26
 Oct 2026 17:06:18 +0100
Message-ID: <2f8371e4-ea8c-45d4-8a42-e1a616915b61@gmx.de>
Date: Mon, 26 Oct 2026 17:06:16 +0100
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
Subject: Re: [PATCH v2] fbdev: vfb: Validate framebuffer geometry and memory
 size
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
References: <20261026154604.579823-2-bestswngs@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20261026154604.579823-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7ZZRjDKW8rTqXZRnf1eRZrWiCSImLhvZ6wtGBfCy3w8FCxintlw
 vnT291zWB75ARH+JmEZF8CIu5IvzBC+Z8bx6+jjLg9D2awQp3wrc6hyo6K2C0hWSB7sfCT7
 rASylNgAr3Y08cSy41V+NRUlN6YbVWPBw6Uy2WmZOw0s0s+HciP/vzfWoXVcbHupMo4tdjZ
 yfPw0YiDj+O8W1zcwAI/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TEiVj+WWEUE=;L8p7gdfuxuXOnb/cxeO5qXaA9k6
 bdoKBTmuGnN/47HaVh1Ii+3cbm+grkVRnEgstaxPCj+ZFGxR90KV65noT4wAlMiEwnDYKwaa4
 Xi7g/pHdgthhU7Kmet0Gw5F6RNB5WFqmmZOW+u5K+NzKbxRRmeaKavH42mUvMRoedMSpT9tvE
 FJDiVzWfRqSWouH3NjIUF/H25Bq6JzrvLu1YYxfszoiN+MYnpNXCcYv9n44asRP9JAHtWrBwX
 ybw1rncVCy2a7Tn0CIcwm2VPg68V9qp1JtdeJgCSx4lQP90SMg/4HvqvY/mBB2Hn8rS/zIKcw
 cqhHjDZVOvGnUJ4HiBYaylccM/jAiMjXAJ63VdgBh7K/QkPvuGb6VHxwyb28t+KVyPWtIMghD
 4VxDze8Wr7RKloEm452e4VJfgPJbnWc01l1nkkMhl3jycK7F8QSEKx3qj5sFfBzZp6WHWOKzG
 RvQkMGyvis0eyOkOatKR6oFH52DQDm9O0y0+2uadrTTas1feF688bfEdKglBPhjgmo/3ydOx9
 T76Y3klFCeYIsVXZ1jHBb5dfqOLSkVtAMPC+Nfs2LohOW9NZZAINryLF5swvwsvW2jx1zwk4S
 M0KC+25sVZr9MzXzQee4IJGgIHM7gZBWaKeKoH810WL4fmF6KlOHcOoZQt4Hs5QLyaOYCwG7o
 qIwJQpn0UVM9rHt/w/HhzzSZZXcCHsRzvQrCqMS7b2nP8tYG0LoFQ+ilmhnucLdLMcPMg2NuX
 PwsvQg5CCiB5UzqmIaIhWn9mn5T3Eo18l+rIu/O0+evfiDUr7I901qfi9KgvXJCsS6TjH7jxS
 m5025oPpw+ueepb1XIVjDPt1Lmox7BmPHX8B2COxIWr0/03enH7EQI9N/TcEB8h9xvhTcpX/i
 cynIyfP5/A9zIuWKnnlwb9An2H0gkvebbp5S4kFjxGPjcN4ngiaw3UdlXbRADpyttrpgePCsv
 erQE4b2mOmagjqp7ESNsIO+1fKN3gajMD2VFIUvlODivecc+LMxPoIG7aIW8xK0VQTj9CHsOt
 Be3J7FM4/Jz+OADzFasKf5jkk6wYIobL1xyLCSmViNuDNFY4KjVgVcQ9We4k3bdMEpwSawEdo
 NDVc41Bz2mJhqIqm/3+cexMfCZD4UBsXaspOq8KMyevvSOYmRx4pc/d8/7rmxYuG/Y9S1GXgT
 jaJr+yshBIiBPobcKxGyJGOmYGQokNiYaUM8edyS4idWTH6mTH+bLqsrhlzcKaAHt2+WRpsFy
 CtVXbMCqHsum/KVlkHH/CT7QkL5ihqZr26VFRCIG8DmoUo+v5E0lGpi2uoNypsVjSwocv6bPH
 eCmEM4Dj7AgsYnyTOQm8G4oSPpRmcHZRQfNxwT05I6gg1wmjAa7ALQDeynU1WP4MqD7YCXu+w
 peg+sNzPLsQfGPhZIl+pfuMDst/lqiu7NkUL6s4fmtC/kXAzOul0unThIHZfE12d+LHO8z+hm
 WR7wsYS+h9juZHPUVPea9Jcwb761rtp6+s2zVnecqxX3r/m6w/kVWvz0JBKbOLvSnimakhw2K
 xXHRoGiDohn3jBBkVldxLJmzZTpkevlVSQKHZdCkBC10v3N3ERZnVz1Ckkdm9MunDQLEyByhY
 uToePMoocBRRamx2PKKC+lP+I8II8A+FQGHgqkqpnmgjxLQ9HZHwI/899aWRS6aXBzswkDsXl
 x6qycltaxjeeYydQhI2U7MWNYEpId3mlZs1UllWt7hZxk+JpXJKIFZcroWJFO9j1hAXfbOSsq
 6JlDs4TcX29jM/4LZhNm2gaYoBe7Cno4l+f+DHftj/dkgttigjG22pd2o06CaSJnlwOKTSnh3
 QLJGodr+XwSyFdqF0o1IaHbPKosO75Nr1KcT89sUhRKp8wWggzwn8WJZOhuDxhz//LaxA5At0
 8hfMKF+ErMgk6dUfY66/V1ttEfF+raqkD24vYO7y+6OSeCk+pIYa0FCmKN4WtOW6b9kWh16sz
 JyMnlWP9lcIiMFrklXqWp0etfpmlGm8vjWmmO4ZkD484acCfNdu4HQmDzyEKYMpyIu5y9wn3J
 3VfSyUHyWjvPw8er9aSwud4kmmvr9+kPWmkl5dahalIFPTKVcKuw/w/s2CwpQMCX8VTXdvZ55
 EY7arL+toe8wcoYuYCMlEiilQsw1qs4JKzAST7Aqjbrri14L7kkA2ffgJTqHQtpiton1amwHq
 BiSyFnFzxIG0Vcw6Xeyr12Rnr+mUMp0NblxX2Dhd3rn64eP0pwfI9cl8tpokGmfVZSTOmRv41
 9f3g90ZCfgGSuTZYA+A9BfD8krpNwIyP4rY9lGBg76TXNvV6q/ffIZDkwXw9YRvVA9Rlz8O0U
 V1t26Kr4lwag6vgeytAICrhkTggfYPW7dIBgb5kd3bndR1da+iYj4CkQEN0xxQK8Op3cxDrZ3
 YB0QoPXiVOnxI6ELb9oAG2AuK5/r2HKRvlX70y1Jm24ZHuYMIjRVedBGHnV1eAyaYvyxdBhQG
 0b01AJWiif8YPVb8rG2x1AF7u2D0oWNykOtFWOS28HqdU7G3sPH7CmURcIsgywi481my8z902
 9lQDEvTIWhoGhofVHMHGywc/6Cks/0b+sHzZWBgNWzN3wD8/DyYYmcIlwdXS1W0ftZOVSVzqk
 mGezNSDYatgpfkNqQAgqENUZMYrcYwYqrLlFYu9oJOQ+uXnJaIB2eAe55Q2I+GtQR68enGo7r
 8Pq9A0P1VMIwcn0VmwO6FkT5hycBGlBy/6rokNp+I3TGmaAbcsYiz7G8+yHAwYS1Aavbrc6EM
 F1aihxVbc9cHQS/FZLfHun62lGUomtAnIDjI5svTzMNUn3YOihsLemiFOwQ8o5VD25OwXSgef
 65XjFjLqFBrJflpNhTmllzG6vY4QoYhKy9huITvm7Besd02BnkXzd6qkrj9XBFMatHVQ/gMvN
 ePtQpf79pOCOu++WvXQQ9KWWhiMliRPMVqMZ9XVO3ox4FxTg2qgZGnDg7aE8rFmw2DjdSUrd1
 kRSl2oCmSipXBBeXyUZkZ1PWAwUg0WrurzB2ZTPkcKIrtZFVn0e7OpUKM/3PNBElqfvNqvJLM
 21/qcmlMHmWql30C1M9jRzSPMGyDob4OcNGnFYq2XBLaDSOjpuCzhelFGmAxxg9wZ0mljdNVd
 Hd7mzVyPbhezQM1lqkeVfzEuHXDOWrx1LbFtqmfIeAP044CoJY1gb7mx+QZwrQwxGmp3nlWfs
 +IlH064m09oYtPt/6wef5iuuXXYy11aXDV+XhBrmCOBgAqFEV+/RSlHEDRBK8zATj/syemr3D
 dQVdYwu+WiWyu8cuIbXYK+LY5o5X5pv1w1i05Oo9FBIcYG1xWFZplzQLVVmtFU9iqgvBZZWG/
 x2awIBjD1gFuCxsHOSrj3YQckKx2RirCG7PwVcgH6ttsr+yJBt9filTaXe85K31ONIRl1v78b
 i/QVWDTJUbiKvDpro1b5CXg802ybkOHFXN27/sOK89XUt/ACimoPHX9mDojozzSMEwjuf3brE
 Sv0/+6x0EbuCZ/Ty5i7y0bAkgN1/PR7lagPCxUkw7snI3gBuoIy6jTQErQZvcP+NCoejphphr
 laSZx8jwSDIKCY88dlDOaSDqsa9szRs/34y8aEYIWv5y37M8v3u1TfbDXrnCcpqRFaJM5Tkhy
 npTq/a96gqWzNeltWw/i+AiWw5IxgBzudCSK/MUskoGLfQ8/00K1s5Btx/9Nw3C5EbLHiU/bQ
 GU4o6Uple2NsEQ5SrGRS6S7Lp94X8pG3ug925iJDDZTJf1AxaT8yAX1f4IjYcYR7ACEwIW506
 2dfwwOG8ZzZXQ8MOmvAhebkBSEax/3dgLfekuNqi54ricfT1PXNn7RXD2b53YZSVBMQUU05Bd
 F2Zbt8e007iIykfAwG5F1RTa1GWhLSAIV4uOQeaRHYp5fp1U6BFje1Jh146M/cDR4zk6bODrP
 T0Aw3qQeMZmtuuKeG7OknyR8emU21hNo2kVn7Gmwps/VEOL00ttFOuA1Q8nU8w0FBwAtjwlaT
 5C01i02AFDLrMj+T+IYf0JI9nrMJSJfRWgR6bkIKIBgLzgGwJRq693mKhU0//pIFFJoUTx8TG
 LH5mIPdXVCUwv29Vrvk78PRmXb9P+cp2hR/7FHpX42e7XzjoIYeY4xCTrLloKvY5On4vI2QMA
 X4ZEmBiu/VpdOerk3zUkhBW3+wf5S9pBvYkqwN1OiC0wC8EzZI0GUhaPHtSX+9/6yS3oINYEh
 fYQRrKtuxHU45zBIeKcq5afrTO6NcE70tBpqiwwihJjRQRdt56fpQKA9tGohLiMyNIuZPCvXx
 U3a8oKt81essCi40X8j50Pk016xzFw2SIH5S0wKuE48BliC7zJGgyH8F3IbK0WpYhQ0E5Fi5p
 MiBXOGBiS8BknqR0FBPjN9A17Ic/SfE2U78hcA2t6lUuP14tXGL9aSswwaMirjsL6SrsHpEKr
 RYBFCv7c6xIkJusqPvyxCF5prCTu8WnhhDA7OZprFSJ5L/JvKvyW5fDzeHwQkbleZbJag0DM8
 P7gkSnrxoCgt30xrl5i/+wDt9Cxf4jT8wxBhcTM1OZCVBaz1VGiRGT4Oa3ZPlmI1q2QpwR1+u
 swlOsyoFVbLiCdAXSI1GnmCA+Byr7BnhJS5npi5ugr0Nt/slLkAkyXjBxJOTcwxgy5EaWFkpJ
 NUNQmsbOzW/HmEuoO8Zb3uKMnLjrIeMUCXiZztR6DpFOULi5m7DtwBnUjY52IyiVRaVJ04zZK
 y2jDMYjqoaN78Bx4BiBTTv0Dsqxh12JWty3ED4HaTXFZ6i46aor2scHi5NcVuViuwiP99H2Dq
 6ILA141iFa/wWJdLu/HQKq6NYPlxWNf655A2Dz12+/VtV6UwvypqffSGbTVFACvYCtdGYS+VU
 crkZnIFPQ+V1/wHR6tVAqDbh/6C7vKwZ95jyHvModYLPPuvrvjUp/BCSCeLP3LJGJr46qV+Dt
 8HQ57sPs4NIupjKz1Ml72l2XPCS2/H8bdLPcopZQWHqOUuljMjTJSSu67lOU8oB/jWkgz49hu
 VsRt/6IIl0udJfUn3hH1TPHk8D2VtlJ9CGDwI472DV+985NgTgQq4OhitUEGhk3wwm6FSfgaR
 F/5CriaLJXyZ/wacTaOHhFnnfpxO2bXUkIhmOjCOP09MpyyAW4Pvp9tXKDcTtNFHAdJf70kM2
 o/AaxYbPdqRp5DSK/DZ6fbNFUtXUgb8ZsuIKXfC9/ELjiIISR2kSNLzpxF7yNmwn0Z1k203/Y
 ixA3dKbFXP8eXstdBuCWWGsOluFdEYBbjCfcjIaPbyD9RXkd+epnNZtSyjWuwJCInU2Y1vPXp
 fbpqPZWXrFpyUKLAkuev8V9ZkP2gWy0S1CLdsXqn2V3TTouWjKVqzvpxVxM63okrAzg2mH+16
 BXsrYgX8Yk2z61IsdeGAessBk6FoWN3LPO1Qh2wLOXWrwLYJL2sPK5Q8tXh7uGkxeqnSLkOFt
 nJtzRMIsGBbXmfL9bFahUYxZw7keOt6HRH9d5pwPUfbi1PUR0hgNVyJSTRG5BY4GjFsFIWRrW
 TYNDM6pgzIagPjFWi2dcsMuEpF0k8SE1C57adMPaQ2RNMIXb0PV+598eStK2brSArScuDPYOL
 ARjDQU9QOeKr5t+gXKZYdfzUlELM/JXDLC67wFHhupSzBfRluI+IM4yt4g5ZiEwuCTYrI0iJ4
 PRUDclehy6LWUdAAzJXddQ0dUgxiYApFQKDIQIQ5Abme8zKgFkSI46mvUIst5g+XdLQ2fr8TF
 vj/7Gx2sLiB8FXlNcVJ8UIxDWA4/9VEHXE1/+ulBbkjTU5iLEclWgvJ+Q07+2EC/1G+/0C7Ru
 0HKBX0/pw9Z1ser/IiPZ3YxpSiCHBM6XNvF/QGM/bpLS6CdiyL5c+x9k4Szsrea6+jeCk6Prb
 XgR2Hdi6/8T1MJrOIds/1a8Pb8/OD1nIr1XPIRJMxEeDJTrPX4sj4ATHpbjAm5QpUS1q/TP2H
 /w9bSJR3hO8XIPcCGiW7b5b0KREKRyg/jYc8cW1FaGARkW/yGfbjZjxUrvMTk/BRLbpuGxRVt
 WEokSpHgpm+4PY4knXWWblOPby8V8jrvydhxGU9OhMFhiOJ33rCtWXD++VepJQyTHDnXmS1FE
 cYNoJK9XYgA2KVanZhCaem+FZNCOBdmvm8/lhDYxPSjZG9+WjlPAIDIZC7I6WMC6o4ts+15h9
 kcYKprUh4WIOMPcLxGs5/R+W15a5xEs+8Frdz2AaTacZSUcfX3CmsBlTCyq6/8KgQO4BS4IGi
 yPnLHMCKZF9QmrK4ls7tHX84YgeLtUk3LQ6r3DC0KH82p+LcaBJfYp0+wYhT/CrdtVcoYQgPr
 20Q4GqYY031dqH6OL9qnhaHQ4psC+01ZfNAvWakLHtHarHA8gTK+x/bCskfKqAorcuP+bgE1V
 uBe+6tREkVQ3EetzoIjQOj+tu9rJyfbJd0JIWKLSMdCDguSB7eLcn8lpsQFXujsz/nT+GTLNg
 whSLUCUFdEZ0LOmKNA9kE2GlrkiYgVWbAxvFlpAovbLydxlpse1BsWhBpAdPMzQQ5F1smmnlK
 B7tzqVR7W/l/lubdEqz4nbOf1SNmYkeIZzVjV7GLzfxXiIHi1dnZxUrDV8qfvdlbK+Fqkuf7f
 KseJM1K2onq/2W8HIBoo3ndBEl5qLdMzWRnWXAeoKOKFfrbG6pov9t9QJZzbgC2Pe9JMk/Cx9
 O2UgI0F1AdTdmCVi4ZfP0CJ6Lfme2iYiW4vbYHoKDmePdcRB935Fetvo8NJaPog==

On 10/26/26 16:46, Weiming Shi wrote:
> FBIOPUT_VSCREENINFO can supply a virtual width large enough to
> overflow get_line_length()'s int multiplication and bypass the
> video-memory limit, allowing fbcon to write past the framebuffer. The
> offset additions can also wrap, while an excessive videomemorysize
> module parameter can be truncated when PAGE_ALIGN() is assigned to
> unsigned int.
>=20
> Limit virtual geometry and offsets to 8192 x 8192 and cap video
> memory at 512 MiB, keeping the stride, framebuffer-size, and generic
> fbdev drawing calculations within their destination types.
>=20
> KASAN reports:
>=20
>    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>      drivers/video/fbdev/core/sysfillrect.c:24
>    Write of size 8 at addr ffa0000001671000 by task poc/198
>    sys_fillrect
>      drivers/video/fbdev/core/sysfillrect.c:24
>    bit_clear_margins
>      drivers/video/fbdev/core/bitblit.c:247
>    fbcon_clear_margins.constprop.0
>      drivers/video/fbdev/core/fbcon.c:1410
>    fbcon_switch
>      drivers/video/fbdev/core/fbcon.c:2261
>    redraw_screen
>      drivers/tty/vt/vt.c:994
>    fbcon_modechanged
>      drivers/video/fbdev/core/fbcon.c:2693
>    fbcon_update_vcs
>      drivers/video/fbdev/core/fbcon.c:2732
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> Suggested-by: Helge Deller <deller@gmx.de>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v2:
> - Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mod=
e
>    support while bounding all generic fbdev drawing calculations.
> - Cap videomemorysize at 512 MiB.
> - Keep the existing arithmetic types now that all inputs are bounded.
>=20
>   drivers/video/fbdev/vfb.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> index de137b2bd..de40ba8c3 100644
> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -31,6 +31,9 @@
>        */
>  =20
>   #define VIDEOMEMSIZE	(1*1024*1024)	/* 1 MB */
> +#define MAX_VIDEOMEMSIZE	(512 * 1024 * 1024)
> +#define MAX_XRES		8192
> +#define MAX_YRES		8192
>  =20
>   static void *videomemory;
>   static u_long videomemorysize =3D VIDEOMEMSIZE;
> @@ -159,6 +162,14 @@ static int vfb_check_var(struct fb_var_screeninfo *=
var,
>   	else
>   		return -EINVAL;
>  =20
> +	if (var->xres_virtual > MAX_XRES ||
> +	    var->yres_virtual > MAX_YRES)
> +		return -EINVAL;
> +
> +	if (var->xoffset > MAX_XRES - var->xres ||
> +	    var->yoffset > MAX_YRES - var->yres)
> +		return -EINVAL;

Instead of returning EINVAL, I wonder if we could simply
cap the resolutions at MAX_XRES/MAX_YRES?


> +
>   	if (var->xres_virtual < var->xoffset + var->xres)
>   		var->xres_virtual =3D var->xoffset + var->xres;
>   	if (var->yres_virtual < var->yoffset + var->yres)
> @@ -434,9 +445,13 @@ static int __init vfb_setup(char *options)
>   static int vfb_probe(struct platform_device *dev)
>   {
>   	struct fb_info *info;
> -	unsigned int size =3D PAGE_ALIGN(videomemorysize);
> +	unsigned int size;
>   	int retval =3D -ENOMEM;
>  =20

and here maybe
	videomemorysize =3D min(videomemorysize, MAX_VIDEOMEMSIZE);

that way the driver loads even if the provided too big value?

Helge
> +	if (videomemorysize > MAX_VIDEOMEMSIZE)
> +		return -EINVAL;
> +	size =3D PAGE_ALIGN(videomemorysize);

