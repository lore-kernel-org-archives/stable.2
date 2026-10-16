Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FA81724;
	Fri, 16 Oct 2026 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181007; cv=none; b=trNV2F6gZPvbW8KNkf1Q8GEEJQ/lNP4BFQ25MQ1hCCdI/b3lfD9/4IIThqZzjJ6BgtGLKHXxlDPMIYQi5ac/9WsOwLgOrITiMXHyFXDSA2hcgkv1L3BLLKZLdsV4kjQaSG0hV81JfcguEy/Yyw9bOw3oeFia2Ble/FSZa8hOeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181007; c=relaxed/simple;
	bh=OZPymKsVyE1AvKyV+4K2m6fwLjrZLCM4GyfeBHYmqS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEMU7OF6r2MQZwe+G6zGNNnJqLSWSC9J7si1zvnpt8lpo89Z9hLb4NaV6/ouX6L1E/VQzJK7ljTLQ5/WEN8gAnP+GDe25KiZ/TSC4CUGE3eYBH9lgAqtWow2cb8ZEAkPevcvLg8YELCkAuZ6HqE9ohTOTeceRlQMiDGEuP3z8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX/h2VfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX/h2VfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB90A1F000C4;
	Fri, 16 Oct 2026 20:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181005;
	bh=qxqlcReFj8P55EZtLex+VC+MtBEl8JX0dg1/eHJsWiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oX/h2VfM7QQzz+A7tLd+PZ9lFuVPLqyFlcy2/5HvWSpVKIHbdxdb/ZySFJc31lLm3
	 L0REnjaMUUdze7oAt4IaXOSEyWYvWyrFLVV8vd1jbDp+a9xUf72hom8+ZJ1Iayllql
	 x7VaPZoG9SPzqlW5TRvr9E3HWa/qD6FqCIl5ADvwO0HprpccwZwJ+4SFBqbwhNKU8u
	 bxchqcJuj0udqpnHPInYLhKoQli+378ga9zlJHfa2nOgv+RGy1bTw4L8TmmQvQ1ojV
	 GkafiBiChnzsXxHE7f8EweYPYSCOz4HyUWqy6rpqmx4YK001AGyUF7+Ivgc3cH4uNm
	 nCcN4QA3eJzew==
Date: Fri, 16 Oct 2026 21:03:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, Gaobin Huang <huanggaobin23@semi.ac.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH 3/4] cxl/mbox: Treat unknown device return codes as
 errors
Message-ID: <20261016210319.5a2a5809@jic23-hlaptop>
In-Reply-To: <3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
References: <cover.1791949910.git.alison.schofield@intel.com>
	<3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 21:17:54 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> From: Gaobin Huang <huanggaobin23@semi.ac.cn>
> 
> cxl_mbox_cmd_rc2errno() and cxl_mbox_cmd_rc2str() use the device's 16-bit
> return code to index cxl_mbox_cmd_rctable[]. A return code outside the
> table's range causes an out-of-bounds read, potentially allowing a failed
> command to be reported as successful.
> 
> Check the return code against the table size. Report unknown codes as
> -ENXIO, the errno used for most device-reported errors, and describe them
> as "unknown return code".
> 
> Found with a QEMU Type-3 device returning codes 001Fh and 0020h, which are defined in CXL 4.0 but not yet recognized by Linux [1].
> 
> [1] https://lore.kernel.org/linux-cxl/20260929060747.3550005-1-huanggaobin23@semi.ac.cn/
> 
> Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
