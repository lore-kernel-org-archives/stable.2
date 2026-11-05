Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902544;
	b=rlJrbchfhHVylRdV2P16DYEw/k8hM3Kjz6rnFtjejtgr5imChTL2XMLJr5xRQJcav3k0
	 2+072EwcTVr0haa84iGsHakSP28/eIFNUj66N0wGGXHpKY3iX1eTt6ZVH36N92z9K32SO
	 /WdYHYtXN+GEsJMZTeiXCHs/BXgJID8VvCx6WY9J4S4hamqG6DACl5gsDJK9EEHx/9ayq
	 K6tDWBtbWR7LDvNXyiR6zEg7x1M8jNNvHYRFRYlkC6HC+JNqkqE1Cg4Qjw4+j4HfvuDN+
	 0p3uLDqTNaDUOirMZQPyteZ63FZxTJlXKmHjEtsfqmA9hZEMjDcxqk2PxWHAnZgFMcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902544;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5xkqUJpXd/77EmurUpWsFnYKGC4PkT/oseXIVCHooLM=;
	b=iYqPsIeeD86QPEtTtfdVv0DV/oph/RqZeEWgIfirmTnIpz+IInB0f+w24nW1EQ1ScxXR
	 2KQ9wOB9r+7YioeYRokbVGhYL6TmRf8DPgj888YE7QGxBAyUHinKl3bRHYC8hG/k8V1jP
	 R5Th7whzVc1HXWr/Ud2flxYqC3kAsxTew8WM0UGXsWnN5Vs5Je/vvHe/B178amWk1x3lk
	 Hf6v7r+e7sjak1eNV1R3aMe3u41KjRS78Nl7EBuTXiLtrbZ09aVkVvxOB0K4NCN4wXXXc
	 tLq04P9iWypedkSH6WspyFBmeiaVzU8v64KuXiZQwHxu+s2aHEjbVAkrmtjKxtFJpgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UupB+5kN;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA9606A326;
	Thu,  5 Nov 2026 18:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33AA9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UupB+5kN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793902543; x=1825438543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1wKu0Wovol8j2e+n6XsWCpw4qH50zSj4siy9b/s3qI=;
  b=UupB+5kN+vPajXA9GXZ+6LO2v6zEKHQnLZljJU5iWtAB5M29eVlSk+DY
   /ECH4M6mkBrSmhP6DjpiCe30ac6CuJ+wLUYCtyRKDz6W+8tHKwBFb501R
   d2JKNKkXtg05YYPoEBfpwahccfnWF57YTHo8nOejgMy0efUh8uI8nm1iz
   BqED5PQGjZKAqUkwkrzlUCb8S8pEUsddTxQ9sy3CFuR0rsuahCees+Kit
   FaA/aTNt7bgH7nt7AgHbm0dZONrDbj25q1r5DqM4nHa6rD6LAq+unAgjI
   6KVHzGK9T/BrEYCIT8ax3XgT7z5QyjkZo+Y1iMYSdfDSjFc+wSm7CXheJ
   g==;
X-CSE-ConnectionGUID: 3HqHgul3Sy+W0p85QkRSrQ==
X-CSE-MsgGUID: 8BPEgiSfTq+/Lieex25lEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2603252"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2603252"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:15:42 -0800
X-CSE-ConnectionGUID: ijpR7fjcTuqXWividS6vTQ==
X-CSE-MsgGUID: 7J+s165sQ6KFNd+rdDoIcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6907461"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Nov 2026 10:15:38 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP1zr-00000000meJ-36Mb;
	Thu, 05 Nov 2026 18:15:35 +0000
Date: Fri, 6 Nov 2026 02:14:55 +0800
From: kernel test robot <lkp@intel.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: Re: [PATCH v3 2/3] media: i2c: dw9719: Update DW9800K driver
Message-ID: <202611060251.DGnOao2F-lkp@intel.com>
References: <20261105-b4-dw9800k_cleanup-v3-2-6850ee6a5a5a@fairphone.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-b4-dw9800k_cleanup-v3-2-6850ee6a5a5a@fairphone.com>

Hi Griffin,

kernel test robot noticed the following build errors:

[auto build test ERROR on bc71431221f5ba8bb33918399552636e059c2c45]

url:    https://github.com/intel-lab-lkp/linux/commits/Griffin-Kroah-Hartman/dt-bindings-media-i2c-dw9800-Redocument-DW9800K/20261105-112900
base:   bc71431221f5ba8bb33918399552636e059c2c45
patch link:    https://lore.kernel.org/r/20261105-b4-dw9800k_cleanup-v3-2-6850ee6a5a5a%40fairphone.com
patch subject: [PATCH v3 2/3] media: i2c: dw9719: Update DW9800K driver
config: nios2-randconfig-1001-20261105 (https://download.01.org/0day-ci/archive/20261106/202611060251.DGnOao2F-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060251.DGnOao2F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060251.DGnOao2F-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/i2c/dw9719.c: In function 'dw9719_power_up':
>> drivers/media/i2c/dw9719.c:207:3: error: a label can only be part of a statement and a declaration is not a statement
     207 |   int ring, sac;
         |   ^~~


vim +207 drivers/media/i2c/dw9719.c

   122	
   123	static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
   124	{
   125		u32 reg_pwr = dw9719->model == DW9718S ? DW9718S_PD : DW9719_CONTROL;
   126		u64 val;
   127		int ret;
   128		int err;
   129	
   130		ret = regulator_enable(dw9719->regulator);
   131		if (ret)
   132			return ret;
   133	
   134		/*
   135		 * Need 100us to transition from SHUTDOWN to STANDBY.
   136		 * Jiggle the SCL pin to wake up the device (even when the regulator is
   137		 * shared) and wait double the time to be sure, as 100us is not enough
   138		 * at least on the DW9718S as found on the motorola-nora smartphone,
   139		 * then retry the write.
   140		 */
   141		cci_write(dw9719->regmap, reg_pwr, DW9719_STANDBY, NULL);
   142		/* the jiggle is expected to fail, don't even log that as error */
   143		fsleep(200);
   144		cci_write(dw9719->regmap, reg_pwr, DW9719_STANDBY, &ret);
   145	
   146		if (detect) {
   147			/* These models do not have an INFO register */
   148			switch (dw9719->model) {
   149			case DW9718S:
   150				dw9719->sac_mode = DW9718S_DEFAULT_SAC;
   151				dw9719->vcm_freq = DW9718S_DEFAULT_VCM_FREQ;
   152				goto props;
   153			default:
   154				break;
   155			}
   156	
   157			ret = cci_read(dw9719->regmap, DW9719_INFO, &val, NULL);
   158			if (ret < 0)
   159				return ret;
   160	
   161			switch (val) {
   162			case DW9719_ID:
   163				dw9719->model = DW9719;
   164				dw9719->mode_low_bits = 0x00;
   165				dw9719->sac_mode = DW9719_DEFAULT_SAC;
   166				dw9719->vcm_freq = DW9719_DEFAULT_VCM_FREQ;
   167				break;
   168			case DW9761_ID:
   169				dw9719->model = DW9761;
   170				dw9719->mode_low_bits = 0x01;
   171				dw9719->sac_mode = DW9761_DEFAULT_SAC;
   172				dw9719->vcm_freq = DW9761_DEFAULT_VCM_FREQ;
   173				break;
   174			case DW9800K_ID:
   175				dw9719->sac_mode = DW9800K_DEFAULT_SAC;
   176				dw9719->vcm_freq = DW9800K_DEFAULT_DIV;
   177				dw9719->sac_time = DW9800K_DEFAULT_SACT;
   178				break;
   179			default:
   180				dev_err(dw9719->dev,
   181					"Error unknown device id 0x%02llx\n", val);
   182				return -ENXIO;
   183			}
   184	
   185	props:
   186			/* Optional indication of SAC mode select */
   187			device_property_read_u32(dw9719->dev, "dongwoon,sac-mode",
   188						 &dw9719->sac_mode);
   189	
   190			/* Optional indication of VCM frequency */
   191			err = device_property_read_u32(dw9719->dev, "dongwoon,vcm-freq",
   192						       &dw9719->vcm_freq);
   193			if (err == 0)
   194				dev_warn(dw9719->dev, "dongwoon,vcm-freq property is deprecated, please use dongwoon,vcm-prescale\n");
   195	
   196			/* Optional indication of VCM prescale */
   197			device_property_read_u32(dw9719->dev, "dongwoon,vcm-prescale",
   198						 &dw9719->vcm_freq);
   199	
   200			/* Optional indication of SAC timing */
   201			device_property_read_u32(dw9719->dev, "dongwoon,timing-control",
   202						 &dw9719->sac_time);
   203		}
   204	
   205		switch (dw9719->model) {
   206		case DW9800K:
 > 207			int ring, sac;
   208	
   209			/*
   210			 * Enable ringing for SAC3-SAC5
   211			 *
   212			 * sac_mode	reg	Mode
   213			 * ===========================
   214			 *	0	0X	Direct
   215			 *	1	1X	LSC
   216			 *	2	00	SAC2
   217			 *	3	01	SAC3
   218			 *	4	10	SAC4
   219			 *	5	11	SAC5
   220			 */
   221			switch (dw9719->sac_mode) {
   222			case 0:
   223				ring = 0;
   224				sac = 0;
   225				break;
   226			case 1:
   227				ring = 0;
   228				sac = 2;
   229				break;
   230			default:
   231				ring = DW9719_ENABLE_RINGING;
   232				sac = dw9719->sac_mode - 2;
   233				break;
   234			}
   235			cci_write(dw9719->regmap, DW9719_CONTROL, ring, &ret);
   236			/* DIV is 3 bits split over the bottom bit in reg 6 and the top 2 bits in reg 7 */
   237			cci_write(dw9719->regmap, DW9719_MODE,
   238				  (sac << DW9800K_MODE_SAC_SHIFT) |
   239				  (dw9719->vcm_freq >> DW9800K_DIV_LOW_SHIFT), &ret);
   240			cci_write(dw9719->regmap, DW9800K_RESONANCE,
   241				  (dw9719->vcm_freq << DW9800K_DIV_SHIFT) |
   242				  dw9719->sac_time, &ret);
   243			break;
   244		case DW9718S:
   245			/* Datasheet says [OCP/UVLO] should be disabled below 2.5V */
   246			dw9719->sac_mode &= DW9718S_CONTROL_SAC_MASK;
   247			cci_write(dw9719->regmap, DW9718S_CONTROL,
   248				  DW9718S_CONTROL_SW_LINEAR |
   249				  (dw9719->sac_mode << DW9718S_CONTROL_SAC_SHIFT) |
   250				  DW9718S_CONTROL_OCP_DISABLE |
   251				  DW9718S_CONTROL_UVLO_DISABLE, &ret);
   252			cci_write(dw9719->regmap, DW9718S_SACT,
   253				  DW9718S_SACT_PERIOD_8_8MS, &ret);
   254			cci_write(dw9719->regmap, DW9718S_SW,
   255				  dw9719->vcm_freq & DW9718S_SW_VCM_FREQ_MASK, &ret);
   256			break;
   257		case DW9761:
   258			cci_write(dw9719->regmap, DW9761_VCM_PRELOAD,
   259				  DW9761_DEFAULT_VCM_PRELOAD, &ret);
   260			fallthrough;
   261		case DW9719:
   262			cci_write(dw9719->regmap, DW9719_CONTROL, DW9719_ENABLE_RINGING, &ret);
   263			cci_write(dw9719->regmap, DW9719_MODE, dw9719->mode_low_bits |
   264					  (dw9719->sac_mode << DW9719_MODE_SAC_SHIFT), &ret);
   265			cci_write(dw9719->regmap, DW9719_VCM_FREQ, dw9719->vcm_freq, &ret);
   266		}
   267	
   268		if (ret)
   269			dw9719_power_down(dw9719);
   270	
   271		return ret;
   272	}
   273	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
