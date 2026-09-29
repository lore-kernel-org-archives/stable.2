Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19B3A168E;
	Tue, 29 Sep 2026 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711191; cv=none; b=n+eU9+Fl2vVdRXR+07eLEPUWmAcbkqcTWG+FkLoDl8X2plRB+j4pYgOCbOYKM4Y3U/A358qfVEsJgyH350BL5GbIqaI5euuLGiY5/YZMr7J1Ot3eDGH70hIkYzgM4d/V2YfMxCcp3/lU9hk6Sus1Y5mjba8hstPcs8fudC4ZCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711191; c=relaxed/simple;
	bh=wNOk8xmLS9mfWQdlbWGk53cHS/yYHTcUHCw82zhext8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRwaLCqcFKQyOxClGOGUxhOSW28Zo3vz0wk/HCBRK3lFCU5dSdc4g2q0kvlGj6O5yXDnA8rMDXnNziwCSOn9unkJfqZvZu7yBa3QYtpAI6qQPejswrkO64w2wvGQ/qrhk8KfV6nGSAQac/PlMopWo6wyOJ3PxXZA1QJjfDV9+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li; spf=pass smtp.mailfrom=gmx.li; dkim=pass (2048-bit key) header.d=gmx.li header.i=arc@gmx.li header.b=sUa2I5vB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.li header.i=arc@gmx.li header.b="sUa2I5vB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.li;
	s=s31663417; t=1790711182; x=1791315982; i=arc@gmx.li;
	bh=zbsBb7RQcFUC4Q8LWygplP+4ERYzPWKqU800XsMGmNs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sUa2I5vBWDAQp1CSsJZKrp6m5RKmsns4erKpsTnY8Dzjqke/y8vNzESCbRymzgju
	 YtHC+b+hO+nFXYyBLKEq8sCER4Sy4zu1TR+//mTS9p4DGi+nABOqI5uXryKrEOfVd
	 BwClQ70ACtshHfwPgUAuAl1sYPSPm0Agk8u4hOzJ92ew4Qy9ijEgIpoxlR7NT7c4x
	 NH/yK6r8dveNHCfea84K+JS1zfWU1UAOX2O+l0LLFhvk2DD0Pqlbeh7tEZ8KNXC9k
	 lhDlQtQHQ2rurVGUrs8tyA/bYd7T2f2Rrng4vRs2afSXpZnu8aFBSvgMo2/JWbno4
	 yRF4L1xPEccXnd6q3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1wX3hh3Z4e-00h6vp; Tue, 29
 Sep 2026 21:46:22 +0200
Date: Tue, 29 Sep 2026 21:46:22 +0200
From: Christian Ruppert <arc@gmx.li>
To: Takashi Iwai <tiwai@suse.de>
Cc: Faaris Ansari <faaris.ansari@gmail.com>,
	Faaris Ansari <faarisansari@googlemail.com>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	regressions@lists.linux.dev, linux-sound@vger.kernel.org,
	=?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires
 quirk
Message-ID: <arwVedydsKxSgpho@khmer.arcnet>
References: <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
 <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
 <2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org>
 <ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
 <2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
 <87tsn838gk.wl-tiwai@suse.de>
 <87mrt01bdg.wl-tiwai@suse.de>
 <87ecec19pa.wl-tiwai@suse.de>
 <0e1a1284-7069-4c46-9f35-57c10c129883@gmail.com>
 <87wls4yvv8.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87wls4yvv8.wl-tiwai@suse.de>
X-Provags-ID: V03:K1:baq9rQfqwBXkNibhNbxjm5R4ask629iaaj0XqhFEd5sJyef4JLU
 kuyDLC7/3x3T1/aeh+wtWzqe062lNZDJ2WKo/g5TylR+Nfza3gq1pV7C9VLvTc7EezYxvKa
 99Sz3jr/WfrGSkfqKKHQJRjFpzgMlgZ/hd3uHariOP9kleOnFvRWq2GAY9CLYiYkKtXzKBL
 QLd8jHgJ2/rKpgJ6WNy9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dj/NKiMwthQ=;AFQpxHVWWXWcDIZKk/F1fF3A7Cc
 iowIq/X8L2mYAKcD4X9ougQJPFLaQOkamlD13wa8WbE8yws58scWdazi2bPNdyOzYVgjLLchA
 zX3RHPCzj+8Ee/WCqBEmsMBhpEI/ezXeQqLLNsqj2z2Rm91giX/8HaGx8mf2ohAGHsAEIsYtx
 HdQYjgQTd/flmr7jbgQWNP4KwLss8UPWtqmkzG37L3k+U/cMhIW8kB/b/z8PoX9lJjVCk/3/o
 oC5Ec8opSllWZUbf11cNveZIZytu3LVoANMHMNMp//sLMw5D90r2k1LrgPP2M9IjEluCrI1V+
 Exk3MBpUDGdb59c4ApVayvppnL0c261d6n1RBF/IEKNHb5fGSDB4zvQuZhqdcmi6u58dDVWdj
 Dpk2VIR7nvsgaMogmAdqDpybdMysRyIs6Y273csNStqhdZApEKv09iV50nubPzEYeaLU7CrrC
 mimmZl2oGrtko8qh2+wXjEKL7qwdfyF2LonoxvBFVlQb/8CM6B8hn8afidijWufGBeeepRmuI
 1JewfqWVeSmBEF8IWkA1QO5Ho8TGYHWPfqfov7/zV2atD18jmEunX25+gN0ltKgNAbP6A7rWx
 kRZ9x7FRsA4IujoOayG8rSu38QStc8xaCnO7Zv+7YxgXd0VVcqGox6LOUyjy/QzexYGJ1nS2D
 NNdQOEmJEntl06lakBEw3xU9p7GRx4L4k7RtvS8uyPRX1ojx6FYaEMR54rsrqJQTLpKpc3HQo
 A5Ue/v3qj2OTrRqGawOJxj+R8wlsydunfEyDnh2D9hInc84IwxzRlUdSlKAhSeD4gWPjqm7XI
 QkMKIB0ZA7feAJgpH/zmUgmO7fPpy14o96zhfwxiOu2wm6ZojuPuCxTjhtqk3/e6NDc7+xgik
 dIqZ98mls+bldlfdTf+Rp4/ht0C44uLG4+3tIUX9UbUcbHWA/q4TGqPt61ap9Lr/CPE6tdkF2
 zDnIj63TuymmkfPYlejZ+9jhLn2oy6jj6VgLaKCgXj19NrOX3gXT6Ga08QtMNFgqy7MfOCglg
 hTV6m0BbW/d8yNA1ai3sDiGoKWPwctRqI58zqWxOVBGnPtdeOfwYgatEUNLJeI0QPu7ss7jnt
 t8vgXyTCzTowtL54PoWrxQbnpyEsTmb9Hc990Cx/QhEynbobartUBlG6BrYFnAdMVU62sjoMT
 lJ1cT4PFWADzA3qTvtsoe9X1QtrSW0PvNhTarONFWlz2AkxzBQ+wEmxcrrxEnbnzQjps5EW/P
 vMhMECCjHcx1TEajOSOG4Nxqigx0MdxwHzsgQYlfzZxdNiFVIb86lIpLtsuP8B+25bWIJmWCC
 WUkgMKcGGbYeXJW4cEMxLzmflmPWa8ftkLrq7WOiGG93mwev16x2oqFd5atDH/8TZtZz4+txh
 d1qdM5l0QJphoYfuF9/QzqK7kEjTGfsXinEG5KicCA8QPvcI9dsDJp5uKD8LKEGoSF2HJ+VjS
 vnVu7q9tA1TCgCOEoCXgGEcsxBSr5VshREnR30t/EQ6kArsJ3DrcvrGmkgZLMMB9YfbpPTeUJ
 JN2Ij7AbAheMX/mc/Q6Edz4yU0wBOA5KAkOfxyBMwJ7/Auc8G/EmX0X+RPzx9WY8CfSm5XGih
 T1Lomikhhpy2osmx5OWlNQA/QYsk3J6mLdFGqI/GlkAdYyTLPsY1ZX8+F99tZQZlvdI3VT1OX
 SmPwd6pDuBM260cErssXqhSy8FeSifVsF/AjqE1WZJ+zSlmZrxAIUgt9UXelty6LZsscXHer6
 WvrdIyABTcWakrCpI2engUF+OauTGl62jww9hAYPmLm7AJ+VOmXd1hmqoxKo10rBgEB3v3DRd
 wkM9dqUVLfG+92Ao6dklBeLRnOnDE2o5vZLbXPzmjfuzAIAjVyClYRsu+OldrgvjfjVw5jwPr
 CjKKp+4JrTpVDGTVwewWGqim/7lu4CobVfV9IvewGK3lyH70g8fqejvojRoMctSe4n9GoOTKQ
 DUsmrI4fo9NNE55pY0Ga0lCyYfBKDOzbddZz2jvWxlA/WhpQ5qnUuUzyWnPVvH9Li6I48Z83G
 BdjSKrk4+YofhxwgZHBvs6GgAAy48jRvNNPYRqdd+nJcQ0eHKbJa7QAXTP26On50pHob78Bqb
 mgnWutXEHHVdXTWkwXSYDBmpwQ07o4nzVs9zKokNgwuyhB433a82roN8VEQZ83Y/mcGWI4XEq
 ijPJJQXr7P6OWEKk4owE6BOpJkossyR/XgSaR7seJmwUJOdGiWiL1XYp7EHHkXeSqEqMLaV9x
 Sc6Va1KefZt2n0LYGNQBRKoF3Pu8uvuB4G8YqDCNaNs1XAEX2B+V3uXH+N7GfzOH/enpu6yjB
 u4rm8jp5S5sxlWRl9z9P3GYPCL9CyuFX3M1d2NuWB0jsbdq3Bwxjox2fDa/eknqwHYs1Ldaz9
 v3DrK8c8139mnT91nly/AVkdabeMwHz5eAJOywavPnmT9aS6uQZ9uk3UU9DXvUBQu7fU+BPDw
 zQYp8Ki7H8vRSoTjJwLjVKEdnyRYz7hSMvDzW+hf0vPgVU5Esb6xDtg1SnDYHbBsib39/7/+w
 KqqvRQAMBgMymQ9raSlpt2V/F7Wey2ONaea++XarcaY8AzT3VgFM+4t+OJ3DoIIXXuqjnTHXb
 UN6dSDv8dZYVsbJ5UmneNz65a0BeriwTuKzxG59fEBqJut+CY3z/ylW/8MLjqx4hFkim7lVW0
 2qX2ztoU5SqBcrzbgGuIUMwSUgNiKalJf87NO+sQ51gKjv+MVVvo0WBBw9KIIT/0R7BVckk7i
 TJRsEdjzOTfSC9efC6atrs11Lcg/ih/lcIWjXKmZD8sDWvw/EQx57NCQtwrZYu50mKtd8Ac/0
 Jr6Y/RsN0BJ/JHUXH3cASFNmCnWOoO7L6twOPkyopSV5Bx6nSoPszXKWakbQc8Aaecn6Y4b/J
 wg7A/KbCA1Nsd1vDOJ4Ws4Kqi+XTI70Qr8IydnaKja75auZGGun0unvHe7YGsy3B3ZpZVJXFb
 vQ3gzmY2i7bAcmWM9kXuVjkY1SEERj1Gqip9t1aiFThE3mo2LtcLI5Eryhdnj7pHz8Tg+h+Ez
 lsSq9oNi9F4uE8YEiN44n56/1Re7MUHzTGGFRDlZXRONrwHJtDssSfU5U2jcYdHtQDhXszrk7
 zAHTLQF7pq3Z94FsAllVbhSmiUYL4bDAdbhoFNhaWMW0lFm/KEGDgtg6tTfDKpkN7HuhtVJwN
 862UG1BsitRTDTl+aGDKHhni5xGf3R/wHj2Na0uuZUo787uxyB+i4P6SCIAj83hmFaOvtut0M
 yaNflpiy2UE6VW2NwGfi+Fttu9Q0tAiwVEQriNcKF8HDbTH1g/9jl867u9pUROcYogOIBVhby
 uXe1vOyjnMuOP+HqQj52RXKSgF43a/YB1zhiv646TxYZO+m67qW70Iyyy3I/2q8Qh0Ml/lOdZ
 X/rR3WtgFsK1wylCnwVG1Oo27yXbkhiyRxXsEu5J4tSijOZrakvZ5jfLiPTJWJREt1V7A2sKk
 S+daZu9i2n2ZS8skTk3NG0Gi7E8kPRVTeBdquUguagJxyEZ5nTIUwMZCydRvdglVVGyM79myV
 +hOLMESAhe8z2m1edbI1S1MZ8nr5NTOONf0rWC9MwWlH6uRNqc1flCtJcm68N+uIJRl4aJRCF
 rrrEDldjbz0oUb5gjNgS6MLCBkpzjYkF+/e2AUQwFr8qJvCzZbBxrec7/5xdnLipOULIwto1N
 4d33ssg6JLs2HVyh3Tq7eczgbhUbNpSv5FFepLP69DgOxSQC4zKxEBWiMtlg5HsPJvFPF3luY
 QECAnW+72Yds6O9VBiw2TnDbwg6X5mwiMpdO5PRa97ITyOwVpgFNmAmCocT1ciNe3lJGP498d
 TgdpZPwVneW9qU4+TrQIvsNIJyeW4l3YgWNpf+4mNEoC3nFZZLbO0G8CsILOit6zSczzYAibP
 d9vIHC/1IcBM9uXogVREQhR8MhKiF/f4smbvRVjSo41NtnwNgQusf+67LjsEQIgr1Ooq+g5KB
 ogaS8ZO+flpCQPL9LTgby6+ulOZfNL4a0psF1CIfieGYpQDg1hPo2pWP9Qr17dU89O32WrYyJ
 ZOm5caV0gotCxsvrNRyytdXwAg4a/oX50gbnGODniCxjG3zye0XfN6HzeAUheGmMOD9WpV1+a
 EonAkdl0TOpu5g24WFQLu9JHC6Uu587pXoDlK3ZfF5YkJFfBYBM6U7z6E+LAOY5f2Jguj3u3p
 ywXVQeBQhsJ+/H4ueMZfZrqpl6qCiNbOO+HW9U2F5fZOyTq5Vwqsuc26OwqZyKzf7reQF6obu
 LRHdgQcPhxmrAhaGEA3CIoFV3FsJ5OGsreYzKIDKzpCZpSQcG47O+BMnAE2Yt+gjF5UXLnqab
 g9j6FQEfi72q7Cu53JWr/iWCa6AmGV56OPyWBunp7/BAp6dKQl0Jt/yZIyRBuTWDSriqez4qk
 PAztPimQAIyv9ol4kBYfzVcYNAhwAsGmj99iWBRir3IuUnw6wnIfU/8omlwSj/YgcyuMFKuEc
 J8ZaPHMPdT4wz23x2T+jP7ttzt3CznGqvoOOOlvXbrrMBbda+v9ntNw95SK99PGvkJm0wjvSK
 +eO22l4lk0EslZtyCNKrzrmb8PvllE9EEIG6rX0uofCgnD4HVdWodx8y0H/MnoADu2LVoNTIn
 rjbooWF0jGXOpujp6uHs3DZ1nuRJwgBNias14o3vVtQW8U+yrkLDQ9dLM+uzXJRdZFvQi3Mnu
 JJgON9qaVHcv7wWp3iHogepdtZ+M4T2uEYEcVRtLw0tuajLProRb+QYTslJXlZ7SQ2be+zFCA
 6UriSk4lSXG5zLxxVIZ/Adzinj5NF0trz3JbtzJ7WUz4Efao8FhtX1dY/IwD86fswSTglS25g
 EZtKqFjYM/JQGaEV75pEDXEgvy587Q0bOTZNCq2fo1U9I4CHVGtCf9jCRciuUfYTRxAz0DIe1
 i49wxREgLPOueTSpndIcEEoftJCnaauY6aF0FyQaTN+lLXX/jxKOuN9emhcB/Q0kAQz4WraQ7
 z6GWTW0hBqoACuBDTFhtDqlMdCABjfyPAhfxjptd+slUrIN+AWCTUivLxBIDDpcbmlb9og3MD
 H7WCVYQIeW31NWn97fxIe547/7Y9QJEkco2acmLSg7qcaXouh05qgIK1sjTrUI8Puu8KF2xYg
 QqCda9FA/2jGzLsx4hsC1ulAd14ScxowQiOwgof43hzX+Oes8qRdxXhNhNaRYpegZwaaLuV/C
 tT8iQNCdghk1jV+X4qwD63eRqzlG2wpg2CUHW7CHmYVCajPYTHBbIsi9UR5/j6nnaD/K7zmQq
 kg2WTL/cGIKfRxxtwaKlP7cmjkXo048nuHxZADXlkUvTskACvYI83OPAvrgTI4rXKDs+S1aq8
 FEcxOJGSzAJ5gjyEWz/ipgVbTqdG8fz4uksRBZOX7FKjbvDxkhTdFlPTC++khT9cZPcKj6QPH
 9i6qeb4KJKx5aUOzPVtA2DkCyTVU4QOHaffQmGLmpwwF4nTmclrXwH54GO277izjAkmAyPfnf
 ZtoB7AI5uw+OdozH7Bx0Bhz16rSEIuv8UeuYBGaG49nd4N6p0t5+PUy8laWIT785oGZLSPnCX
 SF3GGHUfyijQDF+f4CJb8NJuHxiXgn/EUP/o1JdmZii5XXIOLxZ0PpSPRAitn4L6sP7bx4/NC
 PoOmj0W4HW7RAKnHJHU91QsvsalB08V8lzNDdWET2S6VF717TYbvYPX/BLuPG6SAJ5eUUayJ7
 oJyRMvy3R2dXQCUASN6v5p2o4ic1kIWq2SDjXhJRvZo3j33jwUnB5c97Eik9AkQsPo8ZSp5NH
 muWvGwnCmDC6d21h/uxLlOyMzlPUohKvy51Rh8nontvfVxFuL2AVBIsuQfibicHhWQcJkwcpx
 F+7j9o8Fe5IG1q5WsCndYCDUFlsQWR27+RRmxwY2knjsBovsET5CQxrVrjisEaDIt5/hvGYDH
 XJL1UmcUXJtoR84As9vqW37mBUPTOw8bIeyCbtHZGkTsu+5TweTRBQeo3VIYcZf3vxTpijZu4
 PwLTHZIOsLHGmV0x2D/S1wmKqqCtbk46e9Hm4700hE/srljsJGDHXH+PqYzlypPsFYFce/uBa
 TZhayq/eNXwAWAttiab0s68919oClpcr9+hKW912gqlq3bZYdml95Vd2llG6aP9aUM4jDtKgd
 uoytgQ5YFdnrCy//Rzj5NF98RZFOvfKGOg1dx+OA6ConkE+Zns4dAr4E/agmr88TvtkursA2o
 RknKnWQ/tUyNOOj0FXMLRx1tVheHZAFzajpqwwMiNDpVwsjmWjmOdM7y5iKFWj1p0fgXiCXjj
 ZQWsocFV+JT67rAasx/aP0AYSxU0+enzru1ua/tEf4JMTSvyLBw4mkqnIKi9P45ihnmj26E/f
 SAxEV9DMW1OzbIRab3NvJS/rTu1DphP9yKBhb/Dz/nVPEPXudn9VmVJeVubdOStT3hby04owf
 8DTdLnrlGF0c78Tc3h2smDspw29AEvTsN11dG6WoHWmVWz4=

On Tue, Sep 29, 2026 at 04:28:59PM +0200, Takashi Iwai wrote:
> On Tue, 29 Sep 2026 16:24:24 +0200,
> Faaris Ansari wrote:
> >=20
> > Thanks Takashi and Sasha,
> >=20
> >=20
> > > Faaris, please let us know if this (or previous) one actually works
> > > for you.  Once after confirmation, I'll submit the proper patch for
> > > upstream.
> >=20
> > I tested your latest patch where you removed the quirk for the iD14
> > alone, and instead set it for all Audient devices.
> >=20
> > I can confirm that this has indeed fixed the problem, and I can now
> > correctly control my hardware volume without problems, thank you!

On the surface, this does seem to fix the issue but after looking into it
a bit more in detail, the EVO4 is a bit quirky but its behaviour actually
coherent and expected. I wonder if this should be fixed by simply
disabling error propagation or if it's rather an issue with UCMs. The
situation is as follows:

- The EVO4 presents two PCM devices, each with four channels ("EVO4 " for
  playback and "Mic" for capture).
- In both devices, only the volume of the first two channels can be
  adjusted (Stereo master playback volume for "EVO4 " and two microphone
  gains in "Mic").
- The other two channels of each device are mapped to digital loopback
  (playback) and the digital mixer matrix output (capture) which don't
  have volume controls. Trying to adjust these two is thus invalid and the
  device rightly returns an error.

It is true that the "logical" thing would have been to split everything
into four dual-channel PCM devices, two with adjustable volumes and two
without. For some reason, Audient didn't make that design choice and as
things are the situation is perfectly manageable with UCM and correctly
described in
https://github.com/alsa-project/alsa-ucm-conf/blob/master/ucm2/USB-Audio/Au=
dient/Audient-EVO4-HiFi-0006.conf).

The question is now why the UCM tries to adjust mixer channels which are
clearly not declared as part of the respective "split channel" in that
file. I would argue this is rather a bug in UCM (or possibly an overly
eager "put" function in the generic mixer driver) than in the EVO firmware
or the error propagation. In practice, the error disappears either way but
I suspect that at least part of the motivation behind UCM was to address
exactly this type of issues.

This is rather philosophical and my background on UCM is basically nil so
I would be interested in more educated opinions.

> > > ... or if you have a chance to test Christian's patch set and verify
> > > whether the problem is fixed there, we can avoid other changes:
> > >    https://lore.kernel.org/20260919151840.24371-1-arc@gmx.li
> > I tested Christian's patch alone, without any other changes. The
> > problem still occurred with those patches.
> >=20
> > This was also noted by Christian:
> >=20
> > > As a matter of fact, I made a similar
> > > observation to yours when testing the patch set on the 'sound' kernel=
 tree
> > > and the (very sporadic) issue did not disappear after applying the
> > > patches.
> > And further discussion below:
> >=20
> > https://lore.kernel.org/all/CANBVYRAr8iFGFDgdTcDXuQyXt5M4TddZetsG9o1wbF=
ao03R0yw@mail.gmail.com/
> >=20
> >=20
> > However, using both patches together (as well as a small patch for
> > alsa-ucm-conf) has made my interface work very well - I'm very happy
> > with these changes :)
> >=20
> >=20
> > Thank you for your work, Sasha, Takashi, and Christian,
> >=20
> > Faaris
>=20
> Thanks for clarification.  Then we need a fix like mine in anyway.
> I'm going to submit the proper patch.
>=20
>=20
> Takashi

--=20
  Christian Ruppert                                             <arc@gmx.li>

This message is digitally signed with GnuPG.
GPG/PGP Key fingerprint =3D 4492 2196 75F0 EAA0 981E  B661 1476 F17A 975F 5=
87B
