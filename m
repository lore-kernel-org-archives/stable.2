Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997123AE87
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937321; cv=none; b=tk/sRcv7nADsegO0bSw6baF7eTTHPjWUg4REnxwoqCe8XhPjKE1+Ewmpn2g/P6LyUY3V+pnXgdVlzAVz7U8ZqX1GkWtq6XChkVjv7G3gtr9ccHfBo8UlwJ5jlHTQiHCSIO8LUKxeyjLwEEeLcMhAEA4/mB/GmvP0HoO9c524NhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937321; c=relaxed/simple;
	bh=xENhHu8ieJxoQoAzoiL9U8RFwf1POsxSR5e9NF1HSU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9EM8ELqJZ9FOnTCAwUTBI65a38SS2NVrAMp3xdDRVtYQUGU4pK9dVJKraxcYybAMcsTcrTOnhqTof8BP/FLCKsVO5ZKGd6F4QyJzhDNtCUa/1NNJOfLCqbtVhaL9pDuZuDJjwjgqFnSPwKijkt8nVuJkMJalUoRmqKvFQlX2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNoeuUFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNoeuUFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81191F00A3D;
	Wed,  5 Aug 2026 13:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785937320;
	bh=+y6CtVLDTxKvPSSI0p5/BkRLhQehNrIoeglV3tS+TJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jNoeuUFTuZwqpOj29vDD9+Ap7DtOmqkrwCKE7U9O/ElbJFNcUsGs0yynSy7rYqsEi
	 3lNAfDI9a6UnNrTtfRH8TtN0xUugt9JwFVfr0Nh+E/gXnhQPFjdYxR6JFmnfLhUxIw
	 yA/YnxBIdSoDcRmNqcHoTTNxEVDBKsrNekQ5tzGExwDGjoDojoF4L0GAMuiyd1E0ws
	 zS3LnxqO6tvXy9hqyF52RR/haxWIJXqGgRuf/R/LHigIdlmcuP0y14iGwfodhE1d9Z
	 7LydmHwRB72dTZRVU1XUcAdlt68mCMALBYI+t/8Ny3hAcIkAgh1HwORVSqe2kH4OZA
	 CcwBRLVR5gI4Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id B90EE1980089;
	Wed,  5 Aug 2026 09:41:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 09:41:58 -0400
X-ME-Sender: <xms:oz1zagw7Jtpq38LCp53iBxNTaBQmEtUiHJIPh8-fW8HVa7y7Eyj_hQ>
    <xme:oz1zahycM0IuQ3MrxA_r1kJEPX_LEIMfnHqY7YcIxpw_2gSYeARDiTZBsXiDs8qiv
    F_naBrnPVGTPlYZetHdFGathcjzz4zNrbvITyeRKffOZeUMeK-U-gI>
X-ME-Received: <xmr:oz1zaua1f8qOlCmGPUyr7GIvQF5fzHwoSvWtdeTS_I3WeNze7lTvzKZ7U5E>
X-ME-Proxy-Cause: dmFkZTGZl97BSLZbQHO6DsxbDkss95ErJBT0XzSw7z7ieseX941jHO+tWAqRxZzZbmHQfr
    +1AaMBAHZBeP0GaNdYb8Ffb3OqqHoupE2KTxVpHmBEwJWxKEgwav+IDQXHkPj5E9LSKhI2
    5d27ojVsnDTFRSJf2/mNS7N9sEZnzG7pshpqmdhop/wWnwO5i1J2Y4YzMLX+lDj8s6QfAc
    SlIequoveNF1EmK6/GooH+bc5mt5NCIYTAnz6MjpD5OR9mzyFevq2LsUzEcd+DUmTyuxeu
    vITATcfxnDLdXtHko9/eWlQ6nbs0Js9zapIjRyl/w63RdDLniSoNcpD5fZf/jVhtguj/tV
    F+ppg0JnS/DM2Alb7Arc3SMhtgDADKUllc5gAB8BHrbt9Ri3BR50LHecty4r6JwO8Exl0o
    sdQ0TTa7E9FuXmDT3+abeRA89jxTYXvQTBojmW/KV/Ho96/qebH/hPVQ23P6YjLWOd8lYZ
    CtoghtHIAam24dq2DTDvE92vz6Yw31XH+7Of6xvuZGDLa7xn3eOv79Dcw7ycrmv44k0Ugu
    zwi+EYH5M54ciwBj6+JCECrgIkcoojd5oniJXjrpxX2R3p/bjrZPDyM0I6XY4Tac5e2yFl
    /rH4TqqPJH52ocSvkvYUzX+tYlyTBalvf+esFUP93OZ+Nq6Kf4axsGG4nhzg
X-ME-Proxy: <xmx:oz1zarz-Rbj-s2QJHWmxBgcRb-TxUN34zHOziHVOSMur_LwvO7jOiQ>
    <xmx:oz1zakjf09HsXkBgKEd6npD871GBPgnDDNmlNA1E4gctkKEm_ZJ9lA>
    <xmx:oz1zaqp80EXpzJJse5Ou87YuU_rRR8IQ-BCcZ8cpVLFML2NNt2PefQ>
    <xmx:oz1zajditjEpcEfPxAXXbb407XGciesgtFhr76bHawsFjtHaNSR7Ww>
    <xmx:oz1zatcHwRV277QH3g7Ahg4tGOMsH-qhx-QNmJnu0V9eOjuYO60MXe6q>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 09:41:54 -0400 (EDT)
Date: Wed, 5 Aug 2026 14:41:53 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, david@kernel.org, jannh@google.com, 
	liam@infradead.org, ljs@kernel.org, mhocko@suse.com, peterx@redhat.com, 
	pfalcato@suse.de, rppt@kernel.org, sashiko-bot@kernel.org, shuah@kernel.org, 
	stable@vger.kernel.org, surenb@google.com, usama.anjum@arm.com, vbabka@kernel.org, 
	zenghui.yu@linux.dev
Subject: Re: FAILED: patch "[PATCH] fs/proc/task_mmu: fix PAGEMAP_SCAN
 written state for PMD" failed to apply to 6.6-stable tree
Message-ID: <anM9dsuhztJa_L03@thinkstation>
References: <2026080513-ambitious-sage-b240@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026080513-ambitious-sage-b240@gregkh>

On Wed, Aug 05, 2026 at 11:33:14AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.

Not applicable to 6.6.y.

40de8160ca7f fixes pagemap_scan_pte_hole(), part of the PAGEMAP_SCAN
ioctl (commit 52526ca7fdb9), which was added in 6.7. 6.6.y has no
PAGEMAP_SCAN code, so there is nothing to fix there. Please drop it from
the 6.6.y queue.

(The Fixes: tag points at the WP_UNPOPULATED commit, which is in 6.6, but
the code it touches only exists from 6.7 onwards.)

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
