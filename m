Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C24D7D36;
	Thu, 17 Sep 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644060; cv=none; b=u+BkOvqFOqJRvWUGOvEYuaKrm/bK4ipnIbfrlEihQ/rxg9L0/tQAUymoLJ2q9yWQzrbKuJ3n87bpqx9Vf+bLcQ+iaIg3qd1GyAP3r7UqJ81VAWkPzZwtAaCpbmLnl+g/dQK23b/eXw+O1nYD4yi2oIZhulGhrRSGhdSkwUxO9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644060; c=relaxed/simple;
	bh=JUxXiFZW05igLa+91oD5EKuT24d94zhLnd3l0uNsNzo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d7eProIezmY1mqU8spB19bkqWfUK+SPOn1eRVAtx2agRt6eYfccj+N+JRm16BiAwsBsy6nKIkhh6ddUaV3kC6+U3+f2ipkLK7hN6A4GIEyczdngATOyN8WNoRk3RvIHgXFpuVPDwP4OP70PT6b8+z3XJq6hxzqF6tEW6Y4KDujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EjjPOXlR; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EjjPOXlR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qBT9oEMuSH+QUhAv8dwdu6RDMpOUzUIuwB5dGjyEQHk=;
	b=EjjPOXlRIweH68rSem4lpfEB0qXbK0kdZEsNtk7liGQLLdXcwCFIRzykehkn6T79Hnvxq7xNg
	CNFcC9yCmgsnzg9xT5gBnHHFzL7gxqfJEOmnGmonN9p+Xp2vzl8lN2vPzxSHsh2HDLbHUH8dK40
	0iTbAedqwtZkShJnTPnb1ho=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hltLk0LfJz12LHh;
	Thu, 17 Sep 2026 19:09:34 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 9599640591;
	Thu, 17 Sep 2026 19:20:41 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 17 Sep 2026 19:20:40 +0800
Subject: Re: [PATCH] mtd: ubi: Fix UBI device reference leak in
 ubi_detach_mtd_dev()
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <daniel@makrotopia.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <stable@vger.kernel.org>
References: <20260917103102.2147038-1-vulab@iscas.ac.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <103ef14f-85e7-8f4d-4ba4-eab5e36ddfe2@huawei.com>
Date: Thu, 17 Sep 2026 19:20:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260917103102.2147038-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/9/17 18:31, Wentao Liang Ð´µÀ:
> ubi_detach_mtd_dev() takes a reference on the UBI device with
> ubi_get_device() and drops the matching kobject reference only after
> the shutdown notification has been sent.  When the device is still in
> use and a forced detach was not requested, the function returns -EBUSY
> before that put_device(), so the reference taken by ubi_get_device() is
> never released and the device is never freed.
> 
> Drop the reference on the busy path as well.
> 
> Fixes: 7e84c961b2eb ("mtd: ubi: introduce pre-removal notification for UBI volumes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/mtd/ubi/build.c | 1 +
>   1 file changed, 1 insertion(+)

Hi, Wentao, it has been fixed by [1].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mtd/ubi/build.c?id=31dd710cd84d5dd63c49f640d3a9f36c9699ca95
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 674ad87809df..d81f5e0395ac 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1106,6 +1106,7 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
>   	if (ubi->ref_count) {
>   		if (!anyway) {
>   			spin_unlock(&ubi_devices_lock);
> +			put_device(&ubi->dev);
>   			return -EBUSY;
>   		}
>   		/* This may only happen if there is a bug */
> 

