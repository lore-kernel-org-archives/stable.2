Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229592;
	b=raEUVtfXKSLPifNyjserEaz/Su8DIPW3S2r047p1g1203ghWBPNc6n7X+f6S4E2dm//1
	 rpaTa/kq6YIoCYTD8vk3PMJWoVZMTKoh08PGob/xLCnLUo33F9IS2IafElN3Jl8jTDuV1
	 3zM3aYOp2zNWRW3abNV5E0U/Vvj6m3RTX4kwVDGXb11NycS93eaob2AlVH6eRA3yfIauK
	 OD8XkKHHIAf+GBNfH270QuwqLnMVSlLY8zhk8lpXpgOFOyiPikVvzNEc2Nk/sQ/E1BBHO
	 4YxtdizADyU+awuWrjJlqZH0TIlbvk12kvuQ90/6EXs9ffllM4VfaHp5Lv3nClM/Q1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229592;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=M5XaS0Zod6058OtmcR4y5qY/copfL+BUMUEu0sLQEWQ=;
	b=ilN+eLuHQ46dlWlaU8/cdgX2I41yZkeX4b0OGt2zB9xls+uHeQoxRAstN9RykIbxk1IM
	 Uy97OP9FMSCvzgbR79w35gMbiTHJuBO1UacGdHedZliVt1CU8551isuTbWa5+2XE2mwbQ
	 HGpFmU7lIz4OW5yRYsA3VudviiH9ypb/oxkxtJOK6HHWHyd0lPgewi0W8eg4v5CWWBjcp
	 D9RG8+KSFf2ni+oZYVWarPKw2A0DYV+L9J+VdzPhJdH94WZT2Tz02Plq2VU7YkgM3sgMs
	 NB9AoXioHkESpGm7wtL0FG9vIOdR5sBEZ9wx2awUwF4wXM5WBnvUdcQIR/FUdRrDITw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.46
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635D606A325;
	Mon,  9 Nov 2026 13:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D635D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4jNVQh3QH3zpV2Z;
	Mon,  9 Nov 2026 21:06:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id 6F1E340558;
	Mon,  9 Nov 2026 21:06:27 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0CGaF5JxfFqcoQPAA--.4413S2;
	Mon, 09 Nov 2026 14:06:26 +0100 (CET)
Message-ID: <f5b2a9348436f0ac8a11fe1957174de5cbba495b.camel@huaweicloud.com>
Subject: Re: [PATCH v2] ima: fix races when deleting measurement list entries
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Weibin Liu <liuwb@xiaopeng.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Steven Chen
 <chenste@linux.microsoft.com>,  stable@vger.kernel.org, Zhu Guanglei
 <zhugl3@xiaopeng.com>
Date: Mon, 09 Nov 2026 14:06:14 +0100
In-Reply-To: <179422925743.761920.15976497107095793440@xiaopeng.com>
References: <20261109123335.432186-1-liuwb@xiaopeng.com>
	 <95b47e1a0a30022ede9f52ce0e80b0f957097b5b.camel@huaweicloud.com>
	 <179422925743.761920.15976497107095793440@xiaopeng.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:nRC2B0CGaF5JxfFqcoQPAA--.4413S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASDWrxOrlkpAACsH

On Mon, 2026-11-09 at 21:00 +0800, Weibin Liu wrote:
> On Mon, 2026-11-09 at 13:49 +0100, Roberto Sassu wrote:
> > Is it still true with the new semaphore?
>=20
> No. That paragraph describes the unpatched code. The patch serializes
> writers with ima_measurements_rwsem and protects the lookup and cut
> with ima_extend_list_mutex.

Sorry, the comment was not in the right place. Is it still necessary=20
to take ima_extend_list_mutex to determine the cut position, since now
writers are serialized with the semaphore?

Roberto


