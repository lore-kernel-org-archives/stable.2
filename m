Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68F2E1746;
	Mon, 22 Jun 2026 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125210; cv=none; b=fFVSf6DdLzDLAuFBNfsVtEva/ZkjvzFy6gzb3Yt+PqMiVz6TqIYWOx9jeasoQKbRbxu0rHHFaPAV8BV9XsEMUWuSIxqHXDJN5ZRu/KbQQvAH2l35VGDzOnN53KJMds+jt9Y7M5nMo9ol43HnXibpG61N0rRqM/LMrgprFNLiE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125210; c=relaxed/simple;
	bh=+ZO1iASMF+CRlK9jmJVMgpITx+bJg3PMb2ZjSbxVFzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyL6G58hObHaET5eeZPDjseaqg/KQQU3uZJGlAS8nBHN4ta+B8zXXW9pOSxPyHK3JDTF3LVhpB3remMl8fj65kUZDLa0PTJ7/oje6ES7vtyZWg0m7aH6HYs4CVF1LpKLxxuRpnwT/BHLIoPM6iHn5ETNsixv3lchuQcJmstmiT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPc0MXrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPc0MXrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BEA1F000E9;
	Mon, 22 Jun 2026 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125209;
	bh=vsh49OMZYO1Tlv9qz7wIhMt5WYyYMgq7eYLYxvaCqgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LPc0MXrPZ2OyDKy0FSGAGs5H0IlssIhfEEwcY3m+hHlKAQZl48CEUfc1PkTxilfL+
	 GuOfsK/w5B7ak1c2qxKVHcX1X+8BgG83ZcwBIMkS9nwWZLPoxEQUFCTwZV8z8kzg9/
	 SSnYBpNUcd8jP0umEzy30vwN5d7stFqz/vIRWtfVwAKZV03uWLuRzvbc6pEmUUZG7t
	 uL1g5jdtLnVgD4z3pxyBTZ6VWeodLg2h7ObzWCSP26te2mkPUeOH1YSnwseXostBxg
	 7bZS7txVRP00JAyUXlIBo2D7RJn8U7GLv+QJROeePmuLl20dzz2XtoJCVunGmn31dd
	 +5ac+Yn8sIX5Q==
Date: Mon, 22 Jun 2026 18:46:45 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: pawell@cadence.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: fix stream context array leak in
 cdnsp_alloc_stream_info()
Message-ID: <ajkSlRv6e2ck5aEE@QCOM-gEdNzOMOFu.na.qualcomm.com>
References: <20260622052627.696373-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622052627.696373-1-haoxiang_li2024@163.com>

On 26-06-22 13:26:27, Haoxiang Li wrote:
> cdnsp_alloc_stream_info() allocates stream_info->stream_ctx_array with
> cdnsp_alloc_stream_ctx(). If a later stream ring allocation or stream
> mapping update fails, the error path frees the allocated stream rings
> and stream_rings array, but leaves stream_ctx_array allocated.
> 
> Free the stream context array before falling through to the stream_rings
> cleanup path.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdnsp-mem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
> index a2a1b21f2ef8..880097f1007d 100644
> --- a/drivers/usb/cdns3/cdnsp-mem.c
> +++ b/drivers/usb/cdns3/cdnsp-mem.c
> @@ -631,6 +631,8 @@ int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
>  		}
>  	}
>  
> +	cdnsp_free_stream_ctx(pdev, pep);
> +
>  cleanup_stream_rings:
>  	kfree(pep->stream_info.stream_rings);
>  
> -- 
> 2.25.1
> 
> 

-- 

Thanks,
Peter Chen
