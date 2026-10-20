Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503753;
	b=p+E966ZMOkZoDjPmjt9nnLRLxh0HUwrjy+HTiu5PDrBWLElIOyFmvnB0TnN2XnRs5EyS
	 C3cgqkj9Z9BRJi27Q+ega3p7qOsPDfgMBBHcfxE3r9nuPZmYp+rPpr3+5pY8HnKVi9QUU
	 3klUivGPcF6F2+L9dn7wLj6qDGt+uPbv2Cu7AYAK3fXBxtjQ0Xgj6ihQDCOHcSM484fBp
	 JImEPzPiJFxyMXU6ePQfA3Nu4Elq2oVQbR5gxIznZJk+g5WC/iTuSzmh3ujz4W/Ei3E2e
	 ZqpfoXh06rYmzdTRYb8fsHRe5YIeVEywtl9vtAnBjM+lDVWjCSrIQ8FyMgmzCsxKE/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503753;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=emi/66x/BabhSf3BDBoOE10h38uK/MW7pPw0XDhUDRw=;
	b=FQAdO05VRUY9L0tm5tNNi2psABf/jIBJBq8zSmpjZ7K833I9QGW55lu7lt6f+2gkMina
	 OtK850/ZAyXdpcwETDIWgNcX8et8o7gtXn7kbQzTuN5n+lVnuMAOk6Pt/7JIlORdSd6el
	 osWg25gyHZNeBDHbc2+aQCrpltNJXp2tMtxhIEIFcK7hiYksSRTrplxdQxuemd5NQUp82
	 OMoOfcERwpWLzJaSYS/nsVmRB4Y+uI5+869rFAL6b0YRkKvWd+mvLQPAIGMW3/4bj3fJQ
	 PfCTAI1zMCazr/runhknOieSk51OiMp5+NxWsrWKu1ukicKTQu+PV6xZcIIH7OIAePg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dDZiP4yQ;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB7606A31B;
	Tue, 20 Oct 2026 13:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BFB7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dDZiP4yQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792503752; x=1824039752;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=gSicUJuQXSumBo1b/yNxSSakGzyaRj409jA06AFNnEo=;
  b=dDZiP4yQxkCA6l+O8pWUlc6KPu40XL1e91tktx+41kVWkXIjOzDF8l5g
   MeD2hkye3P1XB99Wowsl+As+j9sANlks89Ov+m+V0ApMSxk8lr5TuiKZo
   xCDhiFN3N680O/TwjQIwsA9oZ3N+5CRTLYhkS9k5YAuH6egpSNOrjURVQ
   XLy1VvdwrYmliA+a++1MBEq4LiGhi7NiO0CI4QWtuU3+i5kwcreCa/hed
   1pNEUq1Lc4eUvbtjdQM0x94NScruRnH/5d9korKsvUdR1uwh1LUya8oBg
   q3a/Mg1FBy1w3TNWyLoFX7RDLZhb/RJOO8FCBRQojJLV4bq1cvK1EKFnj
   Q==;
X-CSE-ConnectionGUID: dONf+aGqQwOfUJkrbEuB1g==
X-CSE-MsgGUID: CBlISLmLRzikxIIKhgvlzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1239754"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1239754"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 06:42:31 -0700
X-CSE-ConnectionGUID: 1As9G+q3RvCviKEsE4tAuQ==
X-CSE-MsgGUID: DcA7xthFTO6stDhr9wbrUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4605275"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 06:42:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Rong Zhang <i@rong.moe>
Cc: Charles <hanker007@gmail.com>, 
 Navon John Lukose <navonjohnlukose@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261019-lwmi-wmi-new-api-v5-0-71557d28d058@rong.moe>
References: <20261019-lwmi-wmi-new-api-v5-0-71557d28d058@rong.moe>
Subject: Re: [PATCH v5 00/12] platform/x86:
 lenovo-wmi-{other,capdata,helpers}: Improve robustness on faulty firmware
Message-Id: <179250374334.19315.17912913288074703218.b4-ty@b4>
Date: Tue, 20 Oct 2026 16:42:23 +0300
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 19 Oct 2026 23:02:22 +0800, Rong Zhang wrote:

> Some devices do not support LENOVO_CAPABILITY_DATA_01 and define the
> query method as a stub that returns zero buffer. Unfortunately, some
> devices do not implement the stub properly, causing WMI errors
> (including ACPI errors). This was reported by Charles.
> 
> The current lenovo-wmi-* implementation enforces the binding between
> LENOVO_CAPABILITY_DATA_00+01 and LENOVO_OTHER_MODE because of a
> limitation of the device component framework. When the capdata device
> bailing out due to a WMI error, lenovo-wmi-other becomes unbound and
> unable to provide firmware-attributes or hwmon/power_supply_ext devices
> for the other functional capdata device.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[01/12] platform/wmi: Introduce wmidev_exists()
        commit: 6e01338e987886c03e58b3523adb1f1df176822e
[02/12] platform/x86: lenovo-wmi-capdata: Do not stop the AC notifier chain on error
        commit: 3b53e691e907086672b72d0544e4bf27efd4250d
[03/12] platform/x86: lenovo-wmi-capdata: Only allocate sub-master info when necessary
        commit: 6f8252df18828d19030af6538362c6bea59414d1
[04/12] platform/x86: lenovo-wmi-capdata: Store a pointer to component info
        commit: c8b350085917f8ed6412ae53f3f13cfca4d79ffa
[05/12] platform/x86: lenovo-wmi-capdata: Defer mutex initialization
        commit: 9a4102e4185ad37d41b00d263ac05c370f5c9baf
[06/12] platform/x86: lenovo-wmi-{capdata,other}: Only allocate capdata list when necessary
        commit: 50a11dcdbd073a26b152b46d214cc980ecfc8426
[07/12] platform/x86: lenovo-wmi-capdata: Adopt new WMI API
        commit: f44eea1b94819cc3a790c24a9cc77d06738050f5
[08/12] platform/x86: lenovo-wmi-capdata: Register component even on WMI error
        commit: 952f7fcb161aefcbd6528e34a43932be1f64d839
[09/12] platform/x86: lenovo-wmi-capdata: Detect stubbed capdata device
        commit: 41a2ea4df8f036c9420616f29deb8ef5744dfd65
[10/12] platform/x86: lenovo-wmi-capdata: Do not match missing components
        commit: 1e99760fb07fbe568d1163795ad3a31825952d45
[11/12] platform/x86: lenovo-wmi-helpers: Adopt new WMI API
        commit: 87a7c09a9d4092782820d2c28c09df1d85d4cd93
[12/12] MAINTAINERS: Add myself as a LENOVO drivers co-maintainer
        commit: 3c182ededcd4b89d96fdae43a0868b27d93548b5

--
 i.

