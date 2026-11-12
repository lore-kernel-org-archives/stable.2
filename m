Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467154;
	b=AbKasXxa6mfWkx8KOVFF8LNtYEQB3HYf+rI4VJh5qEMDoujO/SzsZnhFbdx4kJTnsqPm
	 H0WXY42EaxFBa4bfWlEJaq3nnvfoGzlFh3MQValYhUkMn61PbU54b6cwlrI0sQGRuNWFj
	 tO4mpPjyF0RnzjHvXlpo1sF3XuT6OGWaQFcTzezhmzSdN36jaD5lrlovuKiji+nlI1+hS
	 ILKdno8dLh3Q2Cp/bwaYaBj8UwdOcfCgw+Mwnak5HGvZ+DXFCQgWH9vxoWVakaJaBc+A8
	 Gy3yMD7+4UU4XZHjeyuGXBiPFsn5pBf/ionEDsd2fvLxLVvkjCz+Xb8FUxS8HH5p/Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467154;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yjgw63NqCLiKUW5C3fZINoaOOUSR1AgugTSVgR+KFOo=;
	b=O0nrybaRUdQqV4KC5in63T80pH+g3QnOC7DaRaRjE72Luqegt29hiiYyOu0lTxaaZuCk
	 8Nkx5YIi5tcnhHFPHbJI16H7RU6gsaaZ7W3x6wrWUqt2NnjymtvdjeP6uk7wkIWf2bF1f
	 t0wkzTBjHknxXPWFz6z9DtQgHktiGVjr0HwcmE5P2CRPTJvM431cRv2T2bIcUO07ksmB8
	 7CexjrVxmQrBa9XwHHkXBIViI+IyLxuqbAvoD3ehl7luBEH09bGOW/Acyrec0q/1B1Wbb
	 6aXE8ui9I358OlTmKWdHqC3GV0pBPA/kLgikdPtAsXXsSY1th/ZCDVvZstV4EuLaJTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KuwoZJek;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586E606A31C;
	Thu, 12 Nov 2026 07:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3586E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KuwoZJek
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794467146; bh=Yjgw63NqCLiKUW5C3fZINoaOOUSR1AgugTSVgR+KFOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuwoZJekLMN8mWyaF2YGHwWmfqkn/WmHaaoXmgU8Qn8CaCL16CnTucYUIhOs/ACWm
	 TkRXqO+Bc156EZv/Pu5cdXsEQfYC8C4D0ciahKInxWt2RL2KCxEHuHzW+E3bkkDWf/
	 Ucd2LzQRAT7CJPmnMBsHChvuCfx+tqGyGwLsfhTY=
Received: from xkeyc-nixos ([119.97.45.41])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 1600A6E3; Thu, 12 Nov 2026 15:05:32 +0800
X-QQ-mid: xmsmtpt1794467132topn8lpex
Message-ID: <tencent_4DA07B856AB3D527AF6828307764B419DC09@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0Ch6pwG9najbuntaqU+rFuHuPNODel4u0UR/4NO8uGqhd72XErgI
	 /MObPYWeVeHPJGyiW0BqV/gu2fbNzLdFKnXNEyYFfaaPkGED5tIjR8rV75myBXK85Xm5qDC++aqH
	 U1blixVYhUSzqE+5LU0mwNXfRsqC2puJV4OU4WZG9Ds+E3hjJmP+Pe4KD9NmfJAgnFQiGH7ABMpd
	 FzNysXTwoONWhWMAxMX/cUWEFna1mkcz1SemjBN8CvMzZwxbkruWta67s9JrVSdZYnD3tsNh3bDo
	 8IPs25DgFFwvfy8IeMn8ZpaMyK5XzXkww9UGyT8CIxXRZMyEFLoytYWQgeD/BEywt+9DanC0esPh
	 /dJSsapZALQc8ajbRYut7cWHUKNW/+RExxrW3x3pChmIdBXfhVzhK1oelbPn8Re46/d8LPdafi9I
	 Pdq8o/EhBM9T+8C/a2nACq/kVYfZ97vGyisa9Aw6NrJWQiHY02+zvumsjr/39MoHKnLRXhR5CL4c
	 tufTWjbdSA6icUN5emKMMocatJ0YNXDs+zOLJ/KfJtwjCTDDD5bLsORABA0/Dth+KY2HNHodCbxi
	 r0R6pjvZbQ9ekMznB5YQdoD2b6nbFePVNLwn2pst9OULUH+FEOOYzqjJhMPRKuaYR9idYxqYdPtH
	 GlkB/Vjk3EzWLLR7wPQicXHz6JW+/VYmcyciW5Yma0tjSHtlVW2kX5YWfATJzCOcbZ2+NsiDRMW2
	 po26RGU1z2ZdMPLtIJZT6CLflQH9Nqib9P2Lc8iwOgPhCyWW4xtif1sSBWeE/+Te6AE5YIhAaftB
	 OJJvnB7DcmiMADblWMvwJo2bCw69soCFrLir9Nj7EbFGfVDIZlKdqA8NAC/bBuugzDrH2fbEIdhL
	 JEF71+r3dw0fCDrUyaowrbNTqLEHBOmca9ZNfhHb/3xoMjeUCBIFXLUM2WW6uPUMZOyoDarEpHgY
	 vGjRoTj9h2xvoJOXzuOgulnqKbbyvRUlTsMQvX/l1XWBDg/Ax7KWlyda3rN9fsQzkoH7KF66bR/F
	 vxXf6kCQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: xkeyC <xkeyc@qq.com>
To: liubaolin <liubaolin12138@163.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ntfs: don't let a fatal signal interrupt metadata reads
Date: Thu, 12 Nov 2026 15:05:29 +0800
X-OQ-MSGID: <20261112070529.102056-1-xkeyc@qq.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <9c227fe2-3344-4aba-8559-6ae456da355c@163.com>
References: <tencent_AF42E4D94D935F34EB985032150C6AD0DF08@qq.com> <9c227fe2-3344-4aba-8559-6ae456da355c@163.com>
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

Hi Baolin,

On 2026/11/12 14:49, liubaolin wrote:
>> +	folio_wait_locked(folio);
>> +	read_failed = !folio_test_uptodate(folio);
>> +	folio_put(folio);
>> +	goto repeat;
>
> Could we keep the reference here and recheck uptodate under the
> folio lock? We're dropping it even when the read succeeded, so reclaim
> could remove the folio before the next lookup and we'd have to read it
> again. We'd still need to check the mapping after taking the lock.

Good point, thanks. I'll do that in v3.

Thanks,
xkeyC

