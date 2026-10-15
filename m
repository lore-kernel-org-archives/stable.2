Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FD439F75;
	Thu, 15 Oct 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060083; cv=none; b=iMnTe+3fnSw0x4suRImAnWKaVCZGOAvvMG7bzB+T/FaV+6SnPZSH2G+XxzHOm7v3wRb1QEPR+tdzRFyC7jfDJ6FwTMcdcYp2q86gm7snsoxoS7j2Nr7DVOAomId5kFwtWXui3cernZrLCGsveJv2lF0kiMW45xJ3ddGb93sQtng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060083; c=relaxed/simple;
	bh=JZ9/4jmbJeCBHPwSgo1TDGUTRv1owDqAWV7mKohbsQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAiM6RXxDU12oWG1wLuTetepwUnq5Sen9meqVvnT1DjTxjgIq+sB9t4+bvVmQ67FYkqhXlt6gq61PmBomgQE8zLbC4hKpRFyCYSHxRWxpVxcdmo1OlUbQ4EAqLTfSDRL8vRZTyMsT78+H+TEyUGtuGF4IMP8oizOD92IAo5FDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YOoo5loU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YOoo5loU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=JZ9/4jmbJeCBHPwSgo1TDGUTRv1owDqAWV7mKohbsQs=;
	b=YOoo5loUEYuaq0txI/H5rEuExv1nkKTKNxF1Lwh2vffHzjWZHTWlTGPtynqNYo
	uI8nnjHg23YF8bgwyro1L0deJu2epbCFkqkeRkWxJEvhEze4rPDq9DrgWIFOB+C5
	6bKYtRoZDSN/O3lqikbQB8ll815ZCizHStReZAkrGwZoI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3fyOPqtBqLrTzEQ--.45522S2;
	Thu, 15 Oct 2026 18:27:28 +0800 (CST)
From: Xia Yan <yana06070@163.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev-bot+sinfo@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] veth: keep carrier off when resizing channels with a down peer
Date: Thu, 15 Oct 2026 18:27:15 +0800
Message-Id: <179205999714.14383.12377248582345992543.discovery-plain@163.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <179205503431.408196.3787158263559792614@kernel.org>
References: <20261015085821.12725-1-yana06070@163.com> <179205503431.408196.3787158263559792614@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fyOPqtBqLrTzEQ--.45522S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1xCF45Gw4DJw45CrW8Xrb_yoWxurc_u3
	97t34Iga1xAFyUJF9rKF45urs7KayYgr9Yy3y8Wa42kw1vyrWIg392qr17Wr109ayqqFs5
	GF45Gw4Yywn3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUG-e7UUUUU==
X-CM-SenderInfo: p1dqtiawqxiqqrwthudrp/xtbC3xCdJGrQqpB9xwAA3M

Hi,

Resending as plain text because the mailing lists rejected my previous
reply for containing HTML.

This issue was found during LLM-assisted source review of
veth_set_channels(). I reproduced it with a veth pair in a network
namespace by bringing one end up, leaving the peer down, and changing
the active end's RX/TX channel counts with ethtool -L. The UP endpoint
then incorrectly reported LOWER_UP.

I built and booted unpatched and patched UML kernels and ran the
accompanying selftest. The four mixed up/down cases fail before the
fix; all eight cases pass after the fix.

I will include the discovery method in the commit message if another
revision is needed.

Thanks,
Xia Yan

