Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012044.outbound.protection.outlook.com [52.103.32.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12A25B09D;
	Sun, 13 Sep 2026 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789333645; cv=fail; b=Mn8zsERAo3CyIiUJ8jdfOMRrZB/sDL46M/UL8XFQoV2RwkwStGm3y5ryomUm+VcIhuOdIVKh4w60Rkut7i7QYzM8wy7P+4a5sH9jK9V0B+d2QFN6hQxkHR6fRndOLoplpsRjmhhFlrqxBEeShIagsaqG9SYp21L4CnsurOTPRl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789333645; c=relaxed/simple;
	bh=Y7MeP86+MlqywpEto8Atj2nRvi4DHxAhdrJT0YUgnts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SHIYYbieu6c1+XAkOE99gffwoCq8MtlqjXhy4b8t942bLtC+I7Lvd7f4fp4fEidxgZ9mz+Fzz/BctgXmAlCsw+o+74/iGJAk5LC+BUbbBflmSle4yPvvqGu2KYI2EKUPcIyyisOQjSUOuRpUQ0izt7CfnPnrT0TkTJDUqbuJPEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=ZXPUYkRM; arc=fail smtp.client-ip=52.103.32.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="ZXPUYkRM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ou3x1wU28X1tnLtZLbSeAh9nk4ornIuyIvyCzmO8AaUGzVFo2wPKwnkm72C/w6em32o5Uic8RtvapLneKovCpg9IvX4vQ6xYCA74Fqs8anUd46vueTtOjMqSgk26ZZE0MBT/GCw68xD9L8zEawRbO+1NOc3GMqosF/II7B5myHK3XLtU2CZNy+1k2Qnhb+rCzshQh6rljh5HuTO6p+e3mO0lTZHNz+ikd3LF8OYs7Gya8RuxJ0xKL7AcUsI9pj3Nuv/GGQlypRB7KdMtBo/hQzomtzJ3/t2rXOOniu3I+e9HkcdD2WQ6hkO8YpKT1MdfiUGkBI1q4c0k5pyBIQ54qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29PB9vAX0a8gFGg+62lWL2j6YAALa/MuIarNs1wtgmk=;
 b=wn4ieJexinUW1WmvQQ4iLh73/Ie+yGfzhs2Y5VUb3tCqhFY1nJuK7W8OuIghPg5OCNbKQ8/nKsBxye+3P7ToV3MlCtR0cvuYt8lG7TAMA3lyw8h8t7J8uKWJtIE6Evclzw8GaGZOn0U2kcmLl/rG4V2IPUltsb5bjQKL2zMLrY74aNBOsqkPomiZGHTsIFNoeMVxXshDCcfjEtTEkq5FjoyMzJwoWLLt97ZkfeeSZBMhcAjxbQeGNwHGjC3Dogg7NrM6oCm93McFVaEcT69mEkm3rRsnABXh4Qb0PIxejmDju40mpc7DpgCJFCQqaJgnz3h63h31+4WpRxikiGYgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29PB9vAX0a8gFGg+62lWL2j6YAALa/MuIarNs1wtgmk=;
 b=ZXPUYkRMP5YwbquyNrKO+Bv4+fD5YzXzmQ2pokybrcjDDIfzCIsdtjkdFwXVb3SOaW3xi0dzEr0W2vMGsc1gMUep4tFg2HLmf4Ws1QzaYkuSLJFULqcowyj4BoK8VN6sCmqRPLAoUKyTjpqZlEt0o1dlbOx8pr06DeRKdRD6jPX8n2KKmbzz01A1sLNd17r6vgi2unj8/Jd3911CkeGPvYrnbJ+MGaRbjzj8tADP50PWlvbhPnxv9rDmKy3i2/TIta7CgHbcRuRBsQfQjeO5pmFNd0ei3dpO3G3hHy6PcM2/bYCjhPlMkRTbHgub7Imvr7bITKa8j914DJZBTqv36A==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS8P251MB0760.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:523::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 21:07:21 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 21:07:21 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mark Greer <mgreer@animalcreek.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] nfc: digital: check DEP_REQ length before reading DID byte
Date: Sun, 13 Sep 2026 22:07:19 +0100
Message-ID:
 <AS8P251MB00019D89BA5CC85DDDCC168EC8BC2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <AS8P251MB00011C7777543D73542B5ADFC8BC2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB00011C7777543D73542B5ADFC8BC2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260913210719.12057-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS8P251MB0760:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b64bd6-0fa9-4fac-4743-08df11dafffe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|23021999003|25010399006|15080799012|25031999004|37011999003|8060799015|12121999013|51005399006|19110799012|5072599009|55001999006|24021099003|41001999006|40105399003|1602099012|10035399007|2607281247196008|4302099013|3412199025|440099028|26104999009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGuH9lbOfueYnz6kZr8v4sc+AVQIkWok4iUJcSs6g1OFq7EBJQbVSTFZ2Iis?=
 =?us-ascii?Q?+bIioenniivf1il88VwaqiIDJB6RU1z+DiyTkeKgA4rdbM+U/KdbwZbJ7mhK?=
 =?us-ascii?Q?1Ym1BwAa9fpKChqG5u6UdOtjUHfjdAsv8m8pH8oAqSQr27jpBZZV5dI9IMIQ?=
 =?us-ascii?Q?2mKqHvrct44mgLkJfByGVmsN48If1UxXvz1VZn3eoD8xZLGB6zfBda6T8kNK?=
 =?us-ascii?Q?+kzohICHSQ1pYflG+r0yXGNQxyHPh27WKIuXoQVhEvL+n+VC8YxCDTttRvO+?=
 =?us-ascii?Q?UBjDfjbn8hMzgnLTAiTv7RKAGSOjY3O/2jiiRmFxjn4N64IYlPB6Bh6G9xPf?=
 =?us-ascii?Q?kMH5hu+dFJxLuDhOl242beHvJ1256ZeUNz5PJukT2Gpu82vpB+WbZiWCVnLg?=
 =?us-ascii?Q?mOh+4wCJCtYr2InCKV5aLP9rwJ2AyuLt9Xgwzbp/ZwkbkOE480idI4IZZQbp?=
 =?us-ascii?Q?Y1WLuyRdETdKDZHKhSv7MSkr9ftnkWBmMsJb+JlLH1K+J7kmNKp7iR0llyID?=
 =?us-ascii?Q?8DxuCUS11p+XnvRra1Mc/8RuE0pbpDjWJObDwo1mnYjJcxPUM5noM8Zffk/X?=
 =?us-ascii?Q?ZuRrWHfO1fAurqyhGl8MYAq+tYy1eDWGPT8N1y07o7sLoyiZvfPKhTW6iuMZ?=
 =?us-ascii?Q?LSiQiO1XwAeT9tc5ZpDPIQE6nt65KTBm5KfFBzxE0LwOJ2hvUTXrZ9MQC1Pa?=
 =?us-ascii?Q?kLPPsL5rYfBw/futlNJZxG+0Ev3AbGeY4ZA9Arbnt7QEhSxcZQlmq9lMQrNa?=
 =?us-ascii?Q?+Ow8x+7oeDT4cZTAmHH5RHsDy9Q+D8ZODKvF8PH7shSQ+kLSWOQuxjIqMnwb?=
 =?us-ascii?Q?AJYRFmTbGaE+x8B5yQ2R7t5UVu7ul7XMQsXc+bI1wSmnismR+nLPkVIW8RD5?=
 =?us-ascii?Q?j074Cv7auCa2qxiIcXysVDu1XTb+K9jtCYyUHHCZ++iF4LtF+6acV9HrPFBg?=
 =?us-ascii?Q?Ysbe6HrnVuwyfyTU+ncd2gMACviquAjkQZW1ZnMrFvK1+22LkqmujT6MhdA9?=
 =?us-ascii?Q?FMz8EEe79u4jbOZOYuJk3haDnqQRSTJEyJE4/JN70KuVfnI554GZPGLz/m5a?=
 =?us-ascii?Q?MlONDiUJwn1G009+CMUgyt2tuhTg2t06eKkuxk9ODa5g+rzBAafkgpiPGWhq?=
 =?us-ascii?Q?oEaXQN0sVPRo58AJomiq3T31lXXbbx5Zu6EToYUT/FHbYEJsUZqBPzbCVqad?=
 =?us-ascii?Q?o9RVE1V1NJNw+5J8?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MptKQeiDtnkam6hlioAKodPzZIp8GsZRZ/PjwtsX/G3fHYqHbbyMRTMKKDzC?=
 =?us-ascii?Q?OVoxBn4KMFsntnYbp29VkI9Vx1zeVlWjaSOisFjjFK+E6WvZ4sBboo8XmWOa?=
 =?us-ascii?Q?PUGfVHk8cOP7w+qEzsZqjRoEiDwvwJXz5DTery13XoRDs8vTVqtbzLTbzglN?=
 =?us-ascii?Q?wK2yQ7RM+y0C619olC+j9My0yFfrM7lhatJnNEuW9lZ1KNhKmNF48qsGRIy0?=
 =?us-ascii?Q?4+qCtjuCFt2P0GXyxE7D+BxVU6Cjwzw/vz3a/ppNt4c9eUlfCC8t380ZGQS2?=
 =?us-ascii?Q?RMuw2YTQ/ysMiny5+EPfKSq/XmMh4h8r5GDYTaK/plw3PV+ZOSxMYs0AaIVM?=
 =?us-ascii?Q?X5b0ovwGGde6uWGTum4tcJcRGjRrTxXHHY0bJBZdNwOzDqHlHjqV77v5pHM0?=
 =?us-ascii?Q?xVKWpBxEJLS/b78gMLzc2k9teEkLvXA3lzDozW/sxa+IB03YmXYNRL3FprZs?=
 =?us-ascii?Q?d7Gk0g7cgu35CFt1On8mwPhKLKuJM9GOJhKCeET+7SjyHBxHRkOCSFSWSRxL?=
 =?us-ascii?Q?rdEZkrob5vG4rLYBPzL5k4Y0cOvXT36YBxk2OMAybeXmqZdQ5iU9ftIRB4JH?=
 =?us-ascii?Q?yS4EfaFHjmMSiuxqh+0tWn0yxkJ2UzV77aM9uIzHe+WfpTY4xCT0ws78SyHe?=
 =?us-ascii?Q?DDJXv2EUbm4zoFxZSFK6cV/VcOA/8eUg+j1Jeju0cPYqYWrqqYbJ0nvAzN44?=
 =?us-ascii?Q?IiHHwusouYmvTvj2EJ9wlEHqQ1awzH4tZxFSG43kGedsAPppvZpDkSyyX6bz?=
 =?us-ascii?Q?1VMRfwkySPBHCeptj1LSQBEyiex35zaNx9PtqfDTpL4b3ksjUqXeH5RL7yy3?=
 =?us-ascii?Q?gpRiFfu7DqtcZH248pt3NKWVK3RUnQaHRN3/KtsmfouQNz/eeCfTwCyllJ5s?=
 =?us-ascii?Q?jbA0bYfn+1jhJ8J0BMjeECIg6+y1XOvpzZFiz5BcvqZFwvhdQuR9Jv3xtqzJ?=
 =?us-ascii?Q?PLJDIz5WXxWA+pSOY77iARlJiCY3Qag4uBoi2+gMInMI5Jvfk8+kqPIM7Yia?=
 =?us-ascii?Q?0WV85gVWWTAp6bxojifpSwSVK6p4lBOVzGHwEhlOgJHfe2n4N4Dq2Rq5nCqW?=
 =?us-ascii?Q?bsh0Fie2IK5V8RoDT+9OxfPyFSrsuy0kKI3d4QTI6QW+adRYPDzwYuSoYcQd?=
 =?us-ascii?Q?MquX/UB6kyfkAyvERL/PUFge6iV8TneGUI1GPHel7ZREgWZPjPwyN6qRqP8U?=
 =?us-ascii?Q?pjPoeD34JmX6u3rYD1Msrk2k/v5c1yMbg2ZEEK1Y+B9wmXn1oPpfZMhT8qXM?=
 =?us-ascii?Q?rnz2vYBKCJim5WK7x1R+05k7P2xaXDxRyOAr27VqkNUcW2cO7Sbh/wu1oo1E?=
 =?us-ascii?Q?RBT+v6/b4iaYr6PWz0dLVSbrn4dwnVa/u96+VXAFaG43rOb2xjsho4qPDaFv?=
 =?us-ascii?Q?44QqeHqWhz2o6gwpfisiI0tfC+Poj5BmrvCK5un4g2r7DhKO0CBzIc0dqOm/?=
 =?us-ascii?Q?JBoNYVDQe4MzNzBYkkhSA8C2Ex2e4KPm?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b64bd6-0fa9-4fac-4743-08df11dafffe
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 21:07:21.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P251MB0760

On Sun, Sep 13, 2026 at 09:24:26PM +0100, Aamir Ahmed wrote:
> digital_tg_recv_dep_req() reads resp->data[3] when the DID bit is set
> in the PFB, but only sizeof(struct digital_dep_req_res) bytes (3) are
> guaranteed by the preceding length check.  A crafted DEP_REQ that is
> exactly 3 bytes long with the DID bit set causes an out-of-bounds read
> past the valid skb data.
>
> This read can happen on every DEP_REQ from a malicious NFC initiator
> when the target device has a non-zero DID.  The stale byte is compared
> against ddev->did, so in practice the mismatch causes an -EIO return,
> but the read itself is undefined behavior and accesses data past the
> buffer.
>
> Reorder the condition so that the length check (resp->len < size + 1)
> comes first and short-circuits before resp->data[size] is accessed.
> The later "size > resp->len" check becomes redundant and is left in
> place.
>
> Fixes: 05afedcb8918 ("NFC: digital: Add Target-mode NFC-DEP DID Support")

+Cc Mark Greer, author of 05afedcb8918, which the Fixes: tag in this
version points at. I missed adding him when correcting the tag.

> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v3:
>   - correct the Fixes: tag; the bug came in with 05afedcb8918
>   - reword the note on the later "size > resp->len" check, which
>     returns early for NAD frames and is now redundant rather than
>     preserved for that case
>   No code change; Simon's Reviewed-by carried.
> v2: https://lore.kernel.org/netdev/AS8P251MB0001F45C42BBD0D16D7B30ABC8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
>   - add the Assisted-by: LLM tag (Simon)
>   - designate the target tree in the subject
>   - collect Simon's Reviewed-by
> v1: https://lore.kernel.org/netdev/AS8P251MB000196084524EB27D62162B8C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
>
> Compile-tested only; I have no NFC hardware.
>
>  net/nfc/digital_dep.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
> index 3982fa084737..ae5407fca12d 100644
> --- a/net/nfc/digital_dep.c
> +++ b/net/nfc/digital_dep.c
> @@ -1117,12 +1117,12 @@ static void digital_tg_recv_dep_req(struct nfc_digital_dev *ddev, void *arg,
>  	pfb = dep_req->pfb;
>
>  	if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
> -		if (ddev->did && (ddev->did == resp->data[3])) {
> -			size++;
> -		} else {
> +		if (resp->len < size + 1 || !ddev->did ||
> +		    ddev->did != resp->data[size]) {
>  			rc = -EIO;
>  			goto exit;
>  		}
> +		size++;
>  	} else if (ddev->did) {
>  		rc = -EIO;
>  		goto exit;
>
> base-commit: df2908090cda368b01ff43709f51890076c56157

Kind Regards

Aamir A.
