Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C3B3F8EDB;
	Wed,  5 Aug 2026 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923532; cv=none; b=JH2mJlyGsxtR/arI2kSzcAMFzGV4OH0nmycHbv3eVyDZMO/xs5aAGQiW+2F24Z23h45K5QbS4/6NSPRLx7oITAU6V7h08FkPiuRRvBtWaGI1O3r4x4gH8cz4Gahhyta9ChW7ruMEPCPxP+kiKNqkhogEGxjsjLAS/LdtpPoPZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923532; c=relaxed/simple;
	bh=y+dkgoLlF7q/4MjGUwbRXCnxQpyMXGChxNHGkNyVgrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYEiKZopKfeq2mQzvwPMEHIYM9GhvTp/s8L4lDdKInqBiCW7PfkpbbACt7N34ohOOuP9IerRZbBhLJ8smrM4pKATZswFXTuprfSRR7ajHw/PZ5XpaiT8H4HkqmvZFPuzT6ns92VlRf6jpE3S9vMiKF3AWys4DIIitqGnm3PBNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csyHawjE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csyHawjE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785923531; x=1817459531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y+dkgoLlF7q/4MjGUwbRXCnxQpyMXGChxNHGkNyVgrQ=;
  b=csyHawjEYaOTxZhvZho2D4DGKqGMSJ0nUG02Arh0uGsudgUko4P0e73p
   ROGFQO2nwpGMTUlCKmPwqi7Jup0UKUDMsSkTQEckCs5LKxD8L2I1DJulT
   0/5HtbYYhpy54zHGIUfUbw9Ft3wtFUhi8NxyqxdFjzQdQUSDeBptXDgrY
   NU/t+GwqJTbFfdJRoivLL9zWzMcZqPsV9HTLZ8efZHWucVdbE2ql/+U7a
   +DWXamSH1T5/LVZGEZGJizeHdB35fUWcjPkfJvqHhNUS3pYMYoPxGvyLt
   HmVEXtRfxxUnXTzowmfVIlwrtvxtK4NFP2CDLG3JfX8nrr3FL7hkCoq+t
   A==;
X-CSE-ConnectionGUID: F3sY0RlrSHC7VagaVUeFhg==
X-CSE-MsgGUID: hrUPmLyFTa+QdL73RVt63g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97087181"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97087181"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:52:11 -0700
X-CSE-ConnectionGUID: QO/V6s/rSNSYTcmWe7w0uw==
X-CSE-MsgGUID: XRKYOvmmRmq4Hl564GEgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="260489537"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.246.218]) ([10.245.246.218])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:52:07 -0700
Message-ID: <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
Date: Wed, 5 Aug 2026 12:52:45 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
 Paul Handrigan <Paul.Handrigan@cirrus.com>, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
 <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2026 12:38, Richard Fitzgerald wrote:
> On 05/08/2026 10:25 am, Charles Keepax wrote:
>> On Wed, Aug 05, 2026 at 12:10:10PM +0300, Péter Ujfalusi wrote:
>>> On 05/08/2026 12:00, Richard Fitzgerald wrote:
>>>>>> Found by an audit of all reg_defaults tables under sound/, the
>>>>>> SoundWire
>>>>>> codec drivers are fixed by a separate series.
>>>>>
>>>>> Wow. Would it make sense to have a regmap helper to double-check the
>>>>> addresses are indeed in-order in those reg_default tables?
>>>>> I am not sure how this requirement can be enforced by just
>>>>> inspection, a
>>>>> warning would help detect this sort of issues on more platforms.
>>>>>
>>>> It does seem probable that anything that relies on people just
>>>> remembering to keep a large table sorted is prone to breaking,
>>>> especially if the addresses are provided by named constant instead of
>>>> a list of hardcoded numbers.
>>>>
>>>> Should regmap check the table when the regmap is first created?
>>>> As it has to search the table during normal use anyway, one extra walk
>>>> when the regmap is created probably isn't a serious overhead.
>>>
>>> But it will be done for _all_ devices which uses regmap on boot, small
>>> things do add up, see my reply to Pierre-Louis.
>>
>> Indeed, if we were to add some sort of auto-checker it should
>> be guarded behind something like perhaps a Kconfig option or the
>> DEBUG define.
>>
>> Thanks,
>> Charles
> 
> regcache_init() already walks the defaults table checking the stride
> 
>     for (i = 0; i < config->num_reg_defaults; i++)
>         if (config->reg_defaults[i].reg % map->reg_stride)
>             return -EINVAL;
> 
> so checking that each entry is larger than previous is trivial extra
> overhead. I think most regmaps are cached.

Right, I think this should work:

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index aa8f2efed779..ce4b11d8a758 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -123,6 +123,7 @@ static void regcache_hw_exit(struct regmap *map)
 
 int regcache_init(struct regmap *map, const struct regmap_config *config)
 {
+	bool sort_defaults = false;
 	int count = 0;
 	int ret;
 	int i;
@@ -149,10 +150,15 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < config->num_reg_defaults; i++)
+	for (i = 0; i < config->num_reg_defaults; i++) {
 		if (config->reg_defaults[i].reg % map->reg_stride)
 			return -EINVAL;
 
+		if (i && config->reg_defaults[i - 1].reg >
+		    config->reg_defaults[i].reg)
+			sort_defaults = true;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cache_types); i++)
 		if (cache_types[i]->type == map->cache_type)
 			break;
@@ -186,6 +192,16 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 					sizeof(*map->reg_defaults), GFP_KERNEL);
 		if (!tmp_buf)
 			return -ENOMEM;
+
+		/*
+		 * regcache_lookup_reg() bsearch()es this array, sort the local
+		 * copy if it is not ordered
+		 */
+		if (sort_defaults) {
+			dev_dbg(map->dev,
+				"Register defaults are not ordered, sorting the local copy\n");
+			regcache_sort_defaults(tmp_buf, map->num_reg_defaults);
+		}
 		map->reg_defaults = tmp_buf;
 	} else if (map->num_reg_defaults_raw) {
 		count = regcache_count_cacheable_registers(map);


-- 
Péter

