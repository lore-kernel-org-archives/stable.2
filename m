Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842C3932F9;
	Mon,  3 Aug 2026 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768416; cv=none; b=NpcYeKxUUTa/+fveuQon9EAHVnTN5E0AMA4T02raskG9kreZ1LrEw34hiL2CwdSfPXVAbJoz1wtl9vPSZaOKdW+DKU6lapRrLstSZ0I+tgdvArVKrNZcuOoj4rbbtPFp5ZNkXE6po+tZAJYGfiNq/tawVdDq/V/ecHnhLbZCnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768416; c=relaxed/simple;
	bh=uOJQvn6ePwCEmnFu9yOTrYq83LR3UMqJA2aQI//M8iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OY/7fADN7PEypv7mObmnsagcGzUtnX4vh5XBzwr747md4/ikdeMoiAMo2MSShdMMirBDaI7KvcVvFiS1qlSgE4I2wJHmQxcAQyjNFBk52tXVaYL1A+xHhfjmvvHqViDChHyXVNXOmEitLTAhQi2/rDQX+MgFHk1yt5BBtSLIZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=w9/gsPtt; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="w9/gsPtt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=S0MpRY0Tk44n+dARSgzv6DDumfwkdCqIhOS0UREYyuE=;
	b=w9/gsPttq6IXx6sBWtVwhH30xGkyCn9MTNoE3H+APgVtLt3nmf7z1CN6MFINkF/SB98XdBfsF
	qhbOmi/4jTx/ddze/B7svhKhcqu+nBVgn7zNZs3uRUHUMuK8dVKIEYv5wHUy0hPPYL7XD1Ws5Sm
	bUOxJ1MNeLKRlHHN5wysSPE=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hDK590J9BzmV7C;
	Mon,  3 Aug 2026 22:37:17 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 7293D4057A;
	Mon,  3 Aug 2026 22:46:47 +0800 (CST)
Received: from [10.67.120.233] (10.67.120.233) by
 whupemo200004.china.huawei.com (7.152.184.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Aug 2026 22:46:46 +0800
Message-ID: <0849c634-16cc-4db7-afdb-c702a66fc7df@huawei.com>
Date: Mon, 3 Aug 2026 22:46:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling
 and clean up trace start
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, Jonathan Cameron
	<jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sanman
 Pradhan <psanman@juniper.net>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "yangyccccc@gmail.com" <yangyccccc@gmail.com>,
	"zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
 <d558a593-ca12-4237-a9b0-5f20441c9d52@huawei.com>
 <20260730222259.67293-1-sanman.pradhan@hpe.com>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <20260730222259.67293-1-sanman.pradhan@hpe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo200004.china.huawei.com (7.152.184.18)

On 2026/7/31 6:23, Pradhan, Sanman wrote:

> From: Sanman Pradhan <psanman@juniper.net>
>
> Hi all,
>
> Gentle ping on this v2 series:
>
>    https://lore.kernel.org/lkml/20260414172451.14331-1-sanman.pradhan@hpe.com/
>    https://lore.kernel.org/lkml/20260417134550.0000027c@huawei.com/
>    https://lore.kernel.org/lkml/20260414172451.14331-3-sanman.pradhan@hpe.com/
>
> Both patches have been reviewed and I don't believe there are any
> outstanding comments. Could you let me know the expected path/timeline
> for merging these, and whether anything further is needed from my side?
>
> Thank you.
>
> Regards,
> Sanman Pradhan
Hi Sanman,

In my opinion, there is nothing more you need to do.
Jonathan and Yicong have left Huawei for a while, and a patch updating 
the maintainer was sent before they left.
I am willing to look after this code going forward, but I am also 
waiting for a response.
https://lore.kernel.org/lkml/20260416094219.25258-1-Jonathan.Cameron@huawei.com/

By the way,  I hope this helps.
Tested-by: Sizhe Liu <liusizhe5@huawei.com>

Best regards,
Sizhe
