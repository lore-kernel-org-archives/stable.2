Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA242DA41
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527492; cv=none; b=YUR6dMtpZ6MOBtqe9GuptuxlYPdZti9I9JAxBtq4tpGPPc96yPQv17cUZxg4OcQX7FZ8/G67Qo2UWH1Cfob7JBnquOlivt9hBlORYs49Z9D1LSXLtVrHgepBk+c+sf/wvGLmq9YkROLzlzFbYHokRxiI9rqO2QtkksibQITpqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527492; c=relaxed/simple;
	bh=GpdmFh0tf8gqKYu/oPkcs8RRgBWc5t5aAN0aHqDrwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8/WmFbFygN9Ak7ev5TKhv0zPF/seyjebAr1GgOe+idWrt0Is+mzHFwGyfYCstM4J6QUA2VL/LmilLX7oYcXwV4QXhdaobnvesFl6fC9OpQD16bfCSJFKhyzG+JazQxK+6icyx06LTVYUToKpUSEO5mwsA3DKz8XoGRkJQToShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4FhlAzJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4FhlAzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6491F1F000E9;
	Wed,  8 Jul 2026 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527490;
	bh=KT7hvXJzaos0xn+ijp1hQi8WdY2j1/oHG4iy9QQIkvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d4FhlAzJtPCKbrmExlknaf54dinXG2TxJXvZAQxkQt4C/g7GtV9CmAvReJsXN1T7I
	 ycox4ARU1IM/bDAQuDRps+vDI5csr8Ipci2MbUDVMAeRG20iIZpevhPb2t0k+ib81s
	 HFApS0b8Z7eaigvXK0eCzwoHxLvZtq+7bYhLlWVfLSyH9NsuemneByBlJgArNbE52f
	 0bqoi+iGHSBYGCFeiltsuQRg638RNNI4Ycx0BuioC+9o7mYz+Jjlvs0x+UcQEDiXkQ
	 cMtr+Pt58R8xSnWy341qCFSfqpFC7gCtCQAor23qJiNvcmzE2v+6fW15TZWBEj+wvm
	 A71PG4GMPZKNQ==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 6.6.y 00/11] bonding bugfixes for 6.6.y
Date: Wed,  8 Jul 2026 12:17:59 -0400
Message-ID: <20260708120501.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 08, 2026 at 05:46:59PM +0800, Wentao Guan wrote:
> Fixes CVE-2026-23451: bonding: prevent potential infinite loop in bond_header_parse()
> Fixes CVE-2026-43456: bonding: fix type confusion in bond_setup_by_slave()

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
