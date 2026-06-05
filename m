Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177064071F9;
	Fri,  5 Jun 2026 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694885; cv=none; b=ea9+nTCZPcjKWaBYJCbHlb1qzJYBZjIBKQXJV1iA0Kq+SgxcyCqXyXvxDqgpy4AU+lvjdjhEZVG6vt/PeaC+TG+3+zoN/WD1HNVpJ6t78MIEwmIhL0qJK9PLSxgymDbYvntvhQOOHi6va9XvMHivtXidNB2ooRsdVCGEi5ROntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694885; c=relaxed/simple;
	bh=BWt4Crh5P8Wb1HYjqLzIV1GAUNhmEgMWcu+ZbqcilNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2n7TiOcjreKBaetEUHn6wzWdK1cHjMpnHmnT7Wyd6PApxjWSKXVEV/r/E4TJTjxPxTuX21pbJKjiBQCuqPmbV/yxGxf+hxbGHbRvvR9m1B35tXp99zp+G5Kcg9OKUJ3/AXXu6dSFJ1waiKF6/L98HMnmXdCeb3hQUstFguhBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfcMfbjr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfcMfbjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780694884; x=1812230884;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BWt4Crh5P8Wb1HYjqLzIV1GAUNhmEgMWcu+ZbqcilNA=;
  b=TfcMfbjr9jJ+YZ5CJCinD6JkOV32j1h33s17g3l5/cl1i4L3q/jZcrZE
   UfJtAkKUBm49XCpzWKtx2ObtisFt8UKj1twbdI7ABcxUBoDsNtTFLJO4f
   /bKXfIuA5e9XnM2F1PBM47SWzvlvNUCT35r9nz1LZjZU1yT0MWtrW9bfy
   6Qsj6GQTXi4+rtyasMwHwtJL2KSl/F3IyTZ8vr0iRlVZYcpL/N95klVZP
   CwT6kS/rbhmDMtw9+6qc659XsSf7GF3pwVHbvZCUfIxY9znHXNnwjc3F4
   Nsk5PFp/g/+M68gh9fXJksNxloRLDomEKsHe25DbSj6nIk+RywTVBjF0Y
   g==;
X-CSE-ConnectionGUID: ypo2kizoQn+q75Idp66Fdw==
X-CSE-MsgGUID: cZKZTh5GQxOIFDgwL+xhhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="85423074"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="85423074"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 14:28:04 -0700
X-CSE-ConnectionGUID: /nt8QBavSxGe8SXhXCGVcg==
X-CSE-MsgGUID: t8/K65XkTxm+BhCXtB5j8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="245074026"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.36]) ([10.125.109.36])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 14:28:02 -0700
Message-ID: <b91e5e09-34d5-49e6-85dd-28d4a5eb3014@intel.com>
Date: Fri, 5 Jun 2026 14:28:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size
To: Terry Bowman <terry.bowman@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djb@kernel.org>, PradeepVineshReddy.Kodamati@amd.com,
 Benjamin.Cheatham@amd.com, rrichter@amd.com
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Li Ming <ming.li@zohomail.com>, Tony Luck <tony.luck@intel.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260605180610.2249458-1-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260605180610.2249458-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/26 11:06 AM, Terry Bowman wrote:
> The CXL r4.0 8.2.4.17.7 RAS Capability Structure has total length 0x58
> bytes (CXL_RAS_CAPABILITY_LENGTH); the Header Log occupies the trailing
> 64 bytes at offset 0x18.  CXL_HEADERLOG_SIZE was defined as SZ_512,
> eight times the actual on-device size.
> 
> header_log_copy() reads CXL_HEADERLOG_SIZE_U32 (128) dwords from the
> RAS capability iomap, overrunning the 88-byte mapping by 448 bytes.
> The cxl_aer_uncorrectable_error trace event memcpy()s CXL_HEADERLOG_SIZE
> (512) bytes from its source.  For the CPER caller the source is
> struct cxl_ras_capability_regs::header_log[16] (64 bytes) embedded in a
> stack-local cxl_cper_prot_err_work_data, so the memcpy reads 448 bytes
> of kernel stack into the trace event ring buffer where userspace can
> read it via tracefs.
> 
> Set CXL_HEADERLOG_SIZE to 64 and derive CXL_HEADERLOG_SIZE_U32 from it,
> bringing all iomap readers into agreement on 16 dwords.  Userspace tools
> such as rasdaemon have grown a dependency on the buggy 512-byte (128 u32)
> header_log layout in the cxl_aer_uncorrectable_error trace event.  Add
> CXL_HEADERLOG_TRACE_SIZE_U32 = 128 and use it for the trace event
> __array and its memcpy to preserve that ABI.  Both callers now pass a
> zero-filled u32[CXL_HEADERLOG_TRACE_SIZE_U32] staging buffer with only
> the first CXL_HEADERLOG_SIZE_U32 (16) entries populated from hardware;
> the remaining 112 u32s are zero-padded, keeping the 512-byte trace ring
> buffer layout intact.
> 
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/ras.c   | 27 ++++++++++++++++++++-------
>  drivers/cxl/core/trace.h | 24 ++++++++++++++++--------
>  drivers/cxl/cxl.h        | 14 ++++++++++++--
>  3 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 006c6ffc2f56..99fb00949c2f 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -8,6 +8,10 @@
>  #include <cxlpci.h>
>  #include "trace.h"
>  
> +/* Check that UCE header definition is maintained to keep ABI intact  */
> +static_assert(CXL_HEADERLOG_TRACE_SIZE_U32 == 128,
> +	      "rasdaemon ABI requires exactly 128 u32s");
> +
>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>  					      struct cxl_ras_capability_regs ras_cap)
>  {
> @@ -19,6 +23,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>  static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>  						struct cxl_ras_capability_regs ras_cap)
>  {
> +	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>  	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
>  	u32 fe;
>  
> @@ -28,8 +33,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>  	else
>  		fe = status;
>  
> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> -					       ras_cap.header_log);
> +	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
> +	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe, hl);
>  }
>  
>  static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> @@ -44,6 +49,7 @@ static void
>  cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>  			       struct cxl_ras_capability_regs ras_cap)
>  {
> +	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>  	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
>  	u32 fe;
>  
> @@ -53,8 +59,15 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>  	else
>  		fe = status;
>  
> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
> -					  ras_cap.header_log);
> +	/*
> +	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
> +	 * dwords.  Copy them into the front of a zero-filled
> +	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
> +	 * event memcpy sees a full 512-byte source and the userspace ABI
> +	 * (rasdaemon) is preserved.
> +	 */
> +	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
> +	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>  }
>  
>  static int match_memdev_by_parent(struct device *dev, const void *uport)
> @@ -204,12 +217,12 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>  {
>  	void __iomem *addr;
>  	u32 *log_addr;
> -	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
> +	int i;
>  
>  	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
>  	log_addr = log;
>  
> -	for (i = 0; i < log_u32_size; i++) {
> +	for (i = 0; i < CXL_HEADERLOG_SIZE_U32; i++) {
>  		*log_addr = readl(addr);
>  		log_addr++;
>  		addr += sizeof(u32);
> @@ -222,7 +235,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   */
>  bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  {
> -	u32 hl[CXL_HEADERLOG_SIZE_U32];
> +	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>  	void __iomem *addr;
>  	u32 status;
>  	u32 fe;
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a972e4ef1936..d37876096dd7 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -56,7 +56,7 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>  		__string(host, dev_name(dev->parent))
>  		__field(u32, status)
>  		__field(u32, first_error)
> -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> +		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
>  	),
>  	TP_fast_assign(
>  		__assign_str(device);
> @@ -64,10 +64,14 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> -		 * Embed the 512B headerlog data for user app retrieval and
> -		 * parsing, but no need to print this in the trace buffer.
> +		 * Embed headerlog data for user app retrieval and parsing,
> +		 * but no need to print in the trace buffer. Only
> +		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
> +		 * the remaining entries preserve the 512-byte ABI layout
> +		 * rasdaemon depends on and are zero-filled by the caller.
>  		 */
> -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> +		memcpy(__entry->header_log, hl,
> +			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
>  	),
>  	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
>  		  __get_str(device), __get_str(host),
> @@ -85,7 +89,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  		__field(u64, serial)
>  		__field(u32, status)
>  		__field(u32, first_error)
> -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> +		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
>  	),
>  	TP_fast_assign(
>  		__assign_str(memdev);
> @@ -94,10 +98,14 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> -		 * Embed the 512B headerlog data for user app retrieval and
> -		 * parsing, but no need to print this in the trace buffer.
> +		 * Embed headerlog data for user app retrieval and parsing,
> +		 * but no need to print in the trace buffer. Only
> +		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
> +		 * the remaining entries preserve the 512-byte ABI layout
> +		 * rasdaemon depends on and are zero-filled by the caller.
>  		 */
> -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> +		memcpy(__entry->header_log, hl,
> +			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
>  	),
>  	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
>  		  __get_str(memdev), __get_str(host), __entry->serial,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..906fb480dad5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -148,8 +148,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
>  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
>  #define CXL_RAS_CAPABILITY_LENGTH 0x58
> -#define CXL_HEADERLOG_SIZE SZ_512
> -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
> +#define CXL_HEADERLOG_SIZE 64
> +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
> +
> +/*
> + * The RAS UCE trace event header array was originally sized at SZ_512/sizeof(u32)
> + * = 128 u32s due to a bug. Userspace tools (rasdaemon) have grown a dependency
> + * on that 512-byte layout. Keep the trace array at 128 u32s to preserve the
> + * ABI; only CXL_HEADERLOG_SIZE_U32 (16) dwords are valid hardware data, the
> + * remainder are zero-filled.
> + */
> +#define CXL_HEADERLOG_TRACE_SIZE SZ_512
> +#define CXL_HEADERLOG_TRACE_SIZE_U32 (CXL_HEADERLOG_TRACE_SIZE / sizeof(u32))
>  
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0

