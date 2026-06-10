Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27493314C2;
	Wed, 10 Jun 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107406; cv=none; b=oiWHSzIlTqnmZRxWVLI68YP28hZjUnG5JrXhmoZNi7aXdrc2qWaLIGYXMs6NRRU8bZ6cTaf6lxWR9EOgKrv1J/ttmbKrYFm34df1HtkK+lGNqP+v8uhD4PRlSeyPphfuGmLVypa+YurbYQibAjaVkU4vGCkVs6Gjcku6XA9j25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107406; c=relaxed/simple;
	bh=2QGjrHy/PRoch3raeOtztmQV+KiNPyVKF+x5MWha63M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPoK/uROxNlkPHp3qHpOIXGIwx/cHgDQebdCaqchrFyUU4UIIlVIiv5HdxflBgxrTZhhn5m4Q9HmxvnDRvdTKphSq+uPXSMtJc+t73NDTpebUXU2jd3jye5K5sbrIcIaab9zlx2zpHWOVX8Vh1iic7/wgdS3KCE1M7DRmi2m++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLOZ6Zel; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLOZ6Zel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781107404; x=1812643404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2QGjrHy/PRoch3raeOtztmQV+KiNPyVKF+x5MWha63M=;
  b=lLOZ6ZelgyeAJQiovI3TdDD5QxDcUWjeXpBdBqVgrAhBY81B9ZsDS7+W
   qfkkv/2TLWkkF4UckOwTfJZJ8F+QU8OS+X/P4TfeRALt+Natw6b2I6Lv1
   ouwh+Ez/qwrKRFScEsIWAVo4MM6u8Q29C415a7vbRVxDusbMvuqBOU4v5
   zRh9b6ZDz5UWhExsl29ErPMhDecr2JKamEJUrInY0xnb6aCjNFfcw5AlA
   d53adWKxLJwn6UCasI9lMQ9luLNug/IKb6eZXt9xjsaSjDptE3JrLrX0K
   6okaj/5DJSCtI/DpksSe2vXBALZOxc8Kqu6ln5UCbzeluqdmfikTIkhUe
   g==;
X-CSE-ConnectionGUID: 24QdbxixTvy7MbSNu2qErA==
X-CSE-MsgGUID: MhSV5aoDTleSd8NvkVc0vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81752196"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81752196"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 09:03:23 -0700
X-CSE-ConnectionGUID: 2KXcPB6cQbagpNdC04+jOA==
X-CSE-MsgGUID: UdTztvqLTKiCm3Pp1WNmfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251297485"
Received: from krybak-mobl1.ger.corp.intel.com (HELO [10.245.246.32]) ([10.245.246.32])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 09:03:19 -0700
Message-ID: <fcf37969-2641-4480-a4cf-3eaf37b7d3b9@linux.intel.com>
Date: Wed, 10 Jun 2026 19:03:27 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
To: =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, notify@kernel.org, stable@vger.kernel.org
References: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/06/2026 20:57, Cássio Gabriel wrote:
> sof_parse_token_sets() reads array->size while iterating over topology
> private data. The loop condition only checks that some data remains, so a
> malformed topology with a truncated trailing vendor array can make the
> parser read the size field before a full vendor-array header is available.
> 
> Validate that the remaining private data contains a complete
> snd_soc_tplg_vendor_array header before reading array->size.
> 
> The declared array size check also needs to remain signed. asize is an int,
> but sizeof(*array) has type size_t, so comparing them directly promotes
> negative asize values to unsigned and lets them pass the check,
> as reported in the stable review thread reference below.
> 
> Cast sizeof(*array) to int when validating the declared array size. This
> rejects negative, zero and otherwise too-small sizes before the parser
> dispatches to the tuple-specific code.
> 
> Link: https://lore.kernel.org/stable/CANiDSCsjR5NHqu_Ui5cOqWdJgFqmYsQ9WR8O7m0WOhngaYXFpw@mail.gmail.com/t/#m9b3be379221e79327cc13fd71009287368ef4f23
> Fixes: 215e5fe75881 ("ASoC: SOF: topology: reject invalid vendor array size in token parser")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
>  sound/soc/sof/topology.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index 8fc7726aec29..bb6b981e55d1 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -740,10 +740,13 @@ static int sof_parse_token_sets(struct snd_soc_component *scomp,
>  	int ret;
>  
>  	while (array_size > 0 && total < count * token_instance_num) {
> +		if (array_size < (int)sizeof(*array))
> +			return -EINVAL;
> +
>  		asize = le32_to_cpu(array->size);
>  
>  		/* validate asize */
> -		if (asize < sizeof(*array)) {
> +		if (asize < (int)sizeof(*array)) {
>  			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
>  				asize);
>  			return -EINVAL;

I think this only partially right, I would cover a bit more:

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 898b94f88706..b0d37ec2bc5e 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/firmware.h>
+#include <linux/overflow.h>
 #include <linux/workqueue.h>
 #include <sound/tlv.h>
 #include <uapi/sound/sof/tokens.h>
@@ -738,27 +739,43 @@ static int sof_parse_token_sets(struct snd_soc_component *scomp,
 	size_t offset = 0;
 	int found = 0;
 	int total = 0;
+	int max_tokens;
 	int asize;
 	int ret;
 
-	while (array_size > 0 && total < count * token_instance_num) {
+	if (check_mul_overflow(count, token_instance_num, &max_tokens)) {
+		dev_err(scomp->dev, "%s: token count overflow %d * %d\n",
+			__func__, count, token_instance_num);
+		return -EINVAL;
+	}
+
+	while (array_size > 0 && total < max_tokens) {
+		if (array_size < (int)sizeof(*array)) {
+			dev_err(scomp->dev,
+				"%s: invalid remaining array size %d\n",
+				__func__, array_size);
+			return -EINVAL;
+		}
+
 		asize = le32_to_cpu(array->size);
 
 		/* validate asize */
-		if (asize < sizeof(*array)) {
-			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
-				asize);
+		if (asize < (int)sizeof(*array)) {
+			dev_err(scomp->dev, "%s: vendor array too small %d\n",
+				__func__, asize);
 			return -EINVAL;
 		}
 
 		/* make sure there is enough data before parsing */
-		array_size -= asize;
-		if (array_size < 0) {
-			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
-				asize);
+		if (asize > array_size) {
+			dev_err(scomp->dev,
+				"%s: vendor array size %d exceeds remaining data\n",
+				__func__, asize);
 			return -EINVAL;
 		}
 
+		array_size -= asize;
+
 		/* call correct parser depending on type */
 		switch (le32_to_cpu(array->type)) {
 		case SND_SOC_TPLG_TUPLE_TYPE_UUID:

> 
> ---
> base-commit: bb451bc01ea42c9e47557638400708e20df34178
> change-id: 20260530-sof-topology-array-size-signed-06abdacb1cdc
> 
> Best regards,
> --  
> Cássio Gabriel <cassiogabrielcontato@gmail.com>
> 

-- 
Péter

