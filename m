Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F363D565F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700313; cv=none; b=SVACx32Cyu6HFtvrG3uNG5iW0fqR+PLL/VyrNnXL/zMLstzkGUUHg+pWtu8ldLrm3SGsf4xrapRT189OPwf6x1/2ien7V42AY5yqLkP/akPKTnBhP5HN0FlVxosL13ywTua5q7jMXplk5WagChiSdfjNKwEJYq8IzevRWczgIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700313; c=relaxed/simple;
	bh=pzAzdR9BiH1mdON2VztnIv4S20nrfvEj1ZZ9bTFcoOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9dcmu7lQOnlwCn9VgNjSMwufSqi9gQ+3El+4ltHuAut7IRLD93qYmbTX4IGQ1ycGd2GdnlPjuOaLbkVpusK0WuEBApVhX5YpOrViyLqGqyM50IR7I2JuPJ2cBnO3LyjRiNAl44eIqz/ufaHvVD0eppUbjM7VyHKB+SsJIi+rMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=c8BEuzcj; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="c8BEuzcj"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so25989845e9.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790700309; x=1791305109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q9JXGfEXa1TAeD9LIbvvMLuTX8tLs2uHeRrwmi+1sAA=;
        b=c8BEuzcjrX4AVbLCCR7BIL/5B5S63QqVq8Pqotkge9Cq+yLyEhoqOIR8V520egSps5
         6fBH7CCX1yBFwnZMTDpxFZhXPL8scqYh3+fjabRM8Zw5n8cXlU4xWkX74bwT1tthsTPR
         dz6A+ZHACZRK60Ks3iPmf8CFqFn2Y9TEVCBbZfiFnIEOD58g48D2fTrIaS/fYwM8EFN1
         6v+j4aYRoibmkkMrKMzEuskzdygn0teiX3sU2PDY1OydALQcBqdWqOiHJSKkMd5Gh8W5
         bap1rBvueGB5HtpagZ+QnE8xSL4nQoHWpgeTWuMksVMBcaDszDW2Zhqi5jwVWlY+VvU5
         6KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790700309; x=1791305109;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q9JXGfEXa1TAeD9LIbvvMLuTX8tLs2uHeRrwmi+1sAA=;
        b=VMUmX10kopxhbUSOVw4M39cLkDeJMxit1nyu7xjQU2ZhUUx7Wpa3h3KCkJkqOLHL6e
         tpmiWVCRCYo0ktEBH3umHxvw9ELHOyCnWst5lXyb4WyUeHg6oHXHsZOC5/Eff1JvutP0
         /xgcWgJeGjAl+NDbtxZzFyMSRycKLlayG4SsIjnAb0zX8KvVnFxwXRJzzddD2RDgHpO5
         ziFYz7iwjSFxzGJNbxKHt9YR2TYfGnidoPrFvijCALzj/IA3+8kHLFDZyGTnDS9wwjot
         La3zrI3gbir8umhNr33fluAwCpmlRvv0pwuToa7OFm4frHWY2BPwnTsggVyji46lYbXy
         2FcQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7p+rQNXQgyT6iQ65A1l5DvryPvzja03glo4bEH3i7cZPZdfnPtHRgW1O0gIIrlDFY9xMW1x8=@vger.kernel.org
X-Gm-Message-State: AFuF++l7txeXC2RI3Gu/E5pECFOR5tDlb11xn0Y/+1yFmk/OPHkLyR1g
	r5R2FYaZwLngB+Wm+1lt1bOi+pmmxug1i9mL5krshdgwF0wnZ+GnLa0FOpGm4LRdH3o=
X-Gm-Gg: AYBFou1e5b0P0pSWVpPwFmIeypOEtv/pZ+hpC7qKjM4LdQdqCGeel26DlgcLsmlnPWH
	VzLN8er9T0N7uWyeghdFjWSVtkf8CxNUVzZbLRjhbTQwOVP8AvMLYTB+pYtxizDxTlpWOwi04C6
	iQ2OB+m1iiCHs0tqJVty0yV9Y29BV7CBOp60vwxFos+FRirswpUoYSl3INmxAb7H0YiqNxyGivG
	Pq/B5YppdB8AcfFWguV6shInMIf1UrRXsZw9Z2DuojEOESmIm0gJVcRd3dCgZlXsLHop1BRgEsS
	nD2ulgjMf4HmXkL0tV3fizQ+s4vX+ZS4sOZfA7SqEWGDBYZDsAJzGcWgu0FbaBKnk/xedbn434h
	nlbyMT2YzACr05mfx6z3P5t/TlTGQy51ngzK+GfLg8ICCkXMqe7Oopf2zMxjwaZp47cSeeFHxQx
	k/Mr/XyHZjKWZIHMYVHFrO5Uxcr89KXX1lN6YAvFqyzXE+stl9YCHRIKMwizMMG8QLJA==
X-Received: by 2002:a05:600c:3b14:b0:4a0:12d6:33b6 with SMTP id 5b1f17b1804b1-4a012d633bamr34824815e9.8.1790700308596;
        Tue, 29 Sep 2026 09:45:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfecb39sm98759315e9.7.2026.09.29.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:45:08 -0700 (PDT)
Date: Tue, 29 Sep 2026 12:45:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org, 
	alison.schofield@intel.com, ming.li@zohomail.com, icheng@nvidia.com, stable@vger.kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] cxl/port: Clear cached dport pointers when a
 dport is removed
Message-ID: <arvrAEJ14KRtypKt@gourry-fedora-PF4VCD3F>
References: <20260928230341.2315153-1-dave.jiang@intel.com>
 <20260928230341.2315153-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928230341.2315153-2-dave.jiang@intel.com>

On Mon, Sep 28, 2026 at 04:03:40PM -0700, Dave Jiang wrote:
> Switch decoders cache dport pointers in cxlsd->target[], and nothing
> clears them when a dport is freed. Readers then dereference freed memory.
> 
> KASAN caught it under a cxl_test load/unload loop with concurrent sysfs
> reads (abbreviated).
> 
> Clear the matching slots from cxl_dport_remove(), walking the port's
> decoders the way cxl_port_update_decoder_targets() does on the add side.
> Scan all nr_targets slots, the target[] allocation size, and clear every
> hit.
> 
> Fixes: 8330671c57c7 ("cxl: Add helper to delete dport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
