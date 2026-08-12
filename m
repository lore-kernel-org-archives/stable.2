Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EE7435508;
	Wed, 12 Aug 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543982; cv=none; b=DyVBhq/ZMC4w1pdTVRPdLFzMVSU0PsC1buWQaV10KuPOqbJ+l3bQXbZT9zc8bpR32d82LBfU8/oGc7SW4BJj/A6NWyDibvlV/jUNn22o8tL3EPf8CchAHhoj3aVXQTlNY5e8HPcU4udq4WE4JXSyXVY6YMYQfUZuM9uDU1sgZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543982; c=relaxed/simple;
	bh=5/qbyJFLZnK5If02zc/1VqK+s8MFUkazuVR13uPkCAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFlPogJzeOy8NQwvF4kbDpqs4H83i51oF1NJ8pXgvWn7Y5w+sGzzX5YnjIJHec9QT/8fyOUMPXDE91dngkOoX3ILDgTnIGyWhLGo2HPtjaVoC5mh12E9UwL9PG9CWlvKWApuNywv9xv3e8w9WXkPyBL7b5t0DLvX/4saEFaEpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=imXr2p9X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="imXr2p9X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56FE153B;
	Wed, 12 Aug 2026 07:12:55 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FFE63F632;
	Wed, 12 Aug 2026 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786543979; bh=5/qbyJFLZnK5If02zc/1VqK+s8MFUkazuVR13uPkCAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imXr2p9XfQPS03rL3hubkL8+FG2FHXooJGyQjzjX3W/99pz2jm1hjYkR5g/1aYUWt
	 hQkF3v+8eSWzuKp844FXIKUqljnnE1hJM69ggiTmcoUbu+IfzZlI91afPKU2vD6xCF
	 86hNIlOqlfnIf+xMUvwnY9erQPoy9Xw8f43IcyJk=
Date: Wed, 12 Aug 2026 15:12:57 +0100
From: Leo Yan <leo.yan@arm.com>
To: moonafterrain@outlook.com
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Linu Cherian <lcherian@marvell.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] coresight: configfs: restrict address parameter value to
 root
Message-ID: <20260812141257.GK15499@e132581.arm.com>
References: <20260812-coresight-fixes-v1-1-53fbf4e73241@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-coresight-fixes-v1-1-53fbf4e73241@outlook.com>

On Wed, Aug 12, 2026 at 05:13:14PM +0800, Junrui Luo via B4 Relay wrote:

> Mark parameters that can hold a kernel address, and give those a
> config_item_type whose 'value' attribute is 0600. Parameters holding
> plain numbers, such as the strobing 'window' and 'period' counts, keep
> the existing mode.

Thanks for reporting the issue.

The patch seems overly complex to me. I'd suggest:

--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -281,9 +281,16 @@ static ssize_t cscfg_param_value_show(struct config_item *item, char *page)
 {
        struct cscfg_fs_param *param_item = container_of(to_config_group(item),
                                                         struct cscfg_fs_param, group);
-       u64 value = param_item->feat_desc->params_desc[param_item->param_idx].value;
-
-       return scnprintf(page, PAGE_SIZE, "0x%llx\n", value);
+       struct cscfg_parameter_desc *param_desc =
+               param_item->feat_desc->params_desc + param_item->param_idx;
+       const char *name = param_desc->name;
+       u64 value = param_desc->value;
+
+       /* The kernel address should print with the "%pK" specifier */
+       if (!strncmp(name, "address"))
+               return scnprintf(page, PAGE_SIZE, "0x%pK\n", value);
+       else
+               return scnprintf(page, PAGE_SIZE, "0x%llx\n", value);
 }

We can add a flag (e.g., is_addr) in cscfg_parameter_desc to indicate
a parameter presents an address. Since currently only pstop's "address"
parameter has this issue, adding a general flag can be deferred until
it is actually needed.

Thanks,
Leo
