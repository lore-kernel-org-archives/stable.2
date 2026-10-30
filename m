Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350533;
	b=KZQuujmwlyXLhs2uHfODBH0XuDx3XZOwq/5N1yDAkRk78MuZF6APfBW45WbFXbhfMg7P
	 TAuOqX6ZqFYzAcppQF/hckXRhHdpsHCR/iYA54QMIOWGfTEQ8CHUko0xjFKRqBxBlmuO3
	 B64vHj5S2uJEI+17Lm+/cIVdXJ/fGQPYuWIQltcVW/OWyLl+w2pUBKFhrBovylda03s/V
	 /x2emgyBAnpw6amoCQQ9kHxhTDfR56NxL0zKT1Xa0bJAuBvKAPZ6I8gZu0gKvd0qwnmpt
	 TzqbyUBNf+Vx2yKVrvovZdqbXuleX06980adPyFYu6sIgB1kcn+XmEU5+8KEX7UGLFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350533;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c81bMtQ3kZBZTifEysXzm9zdHXrSX8m6IroLfszR6E8=;
	b=5TX2NCAISBdTHc+3BIVd75RjJyVyrcMVKeRrCPoydmwFXPQ4siIoaCKIrHz7tNhVf1YF
	 4jYWqYzOrNwPLnWIH3mldlD6iAAayo9b5yIeQJeKLHUZLkOh+3OYE1hqia62fWBos4OS5
	 Rey0nUPNFrEzNS0NCCaC2mKHWw3+iCBtxl91pMosurL9KbnUL5ihmyM+CDyM9O9nSykkM
	 Ng5U6vu/4WtKpxxU/waLFSDOTIb5GblhiAT66BAtZxTnXG6F05ORKk/sx4Ie9MUOiRGQt
	 Xl8onTuxYuFazOpupNxNcwV+PSVQE5xyYSaL9wM4HUaTXQ0pgvlRxvvuzXYxmVXj9jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=cv8crOse;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCC606A31A;
	Fri, 30 Oct 2026 08:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14FCC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=cv8crOse
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793350526;
	bh=c81bMtQ3kZBZTifEysXzm9zdHXrSX8m6IroLfszR6E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cv8crOseoVX2YIfe+aq3jil592HQJLM+nvjt0ScnB+Jlz3fOEHd3EabBPyZaTODUw
	 heZjV0q0/ZIyTeZgixVHGL9s8vTRn6yhqqWGQ6mV0fJ6ZpuyEszgkcAdDtpQECpbNl
	 /aMv5jQSEXYS3ka40PjyTeMZApV07X6Vxohh0sOU=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.246])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id DD912A89; Fri, 30 Oct 2026 16:55:25 +0800
X-QQ-mid: xmsmtpt1793350525tpiykg54d
Message-ID: <tencent_D3A2B2E77AFCC54558476B28B595A9AB3A05@qq.com>
X-QQ-XMAILINFO: MFkgsonL4eTuifrPzxqbLZhxiDaQvSVf88/daCwOJqr55ZbVF+edL6phJGwKvh
	 u3Ljef3i+yxknVp0Nv6JFR6DJKr1i5y9zUwyGhnxf4UlafOmU871sNTI/6jDEPQ/FKjw4YjF3xLa
	 9ngcH69fwx+opQNGPKk1T7ImwiZXM4oZccBOJrC/APiw3ZnCl5L3erWOpHBukYCJka8NNF5xzbwR
	 2ElM1GXI0b9PmRXmUtESDv6ZIXveagg/R6eAOq8d/JjgJ1PBp4wU5kaiKeKDEYlqe9kxIhabmkSi
	 Scm9DKxbloQeBjUQkQWeRC6EilXzCSkvWbwEhThfPLS/4ybLD3mQ/oxUqPnSyVJe6JHZLu5Oy0HJ
	 43EcEh3fsJVksn5kpWoEK8nowqNr/6ToSH7c8biR8WJ9K+K0ZNbmsakMEfUIkb9xGD08K3j/Tmwp
	 WvX6gf5sJ3R1anJ0IFY9bczNGE1APtQ6RWiwNE2HMsWM+lSvQDA6G+zEWPkGCAH2259ddSahTqHZ
	 YGBiPdnQG9x75w9OdJP6kpjXW8sTHtG3HtYtD0g5FfSO03WnGF0WYn2v456pm+s2DVFvdunu1TPq
	 HFR6WO8ChRHdTdvHiji92Opc0l3+/BpDfphvdXsuBrOlI82qfPr3LXpu8zVY02hwLcDtUk0+CJ0K
	 yBy7Rjr+VF+tNCVBxkF4RapnMo3EJneoRJzVNydxGKHqmZzGG9+wRPX4qGG8LBSTm5bFEns7zmBH
	 aQbWSzZCdzQNwhDL3bqDi2Ie33Cby5kwnkuLqScAN0DNzw0jksyrfv8a3eDf56/wf1bnpWHqIafA
	 Uxx0iRWqk4W5vGTZ9rRiqa1h3EOoiDy6d8RdBU8B57E4lEbPurckZYvAOizKsTL5P20Dt1n/pF4y
	 pIP4AdC+8PflWEEAUySD68/L7+F5DYFxW9JlP8tHnyAwtLznqMGFw8a/3qh8qC4VEfFyvuOPY3MJ
	 hfQ3TEC697AU8G/XpAEPoBtJNS1f6lzRVs+A25mZ7EWU51QMkZC2VIdysy65iEhiVZhH24/sDsJa
	 7wYKO5zPbE+ILCRGHmbq3swUNqlAUZ8JyhSrbRlvolQ34WFyZ8vUYF9f5s7tqKTcWITN8Gy+xSxV
	 ff9YQiqFfRC2CkeaCNlAGRl4Z0/sgYKB1N0clZ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: bo cao <treebacker@foxmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srini@kernel.org,
	stable@vger.kernel.org
Subject: Re: fastrpc: use-after-free of fastrpc_invoke_ctx on duplicate glink responses in fastrpc_rpmsg_callback()
Date: Fri, 30 Oct 2026 16:55:24 +0800
X-OQ-MSGID: <20261030085524.80069-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2026103041-handrail-civic-a9fa@gregkh>
References: <2026103041-handrail-civic-a9fa@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

> These two messages are not "threaded" properly, sent as 2 separate
> emails.  Is that intentional?  It breaks our tooling :(

Not intentional -- I sent them individually instead of as a series.
Sorry about that.  Resent as a properly threaded [PATCH v2 0/2]
series with git send-email (no code changes):

  0/2: https://lore.kernel.org/all/tencent_AE37F59DA9A6DAB192F6BAFD054E584FAB05@qq.com/
  1/2: https://lore.kernel.org/all/tencent_E9BD7808AB6A2DA5FA326D547F57D65D270A@qq.com/
  2/2: https://lore.kernel.org/all/tencent_C7D71E2F51C2195A0CA91A4C11D51B957708@qq.com/

Thanks,
bo cao

