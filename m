Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A5367B65;
	Wed,  2 Sep 2026 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328444; cv=none; b=ToNKsxvzOht4d3zcnL/t/QJVF0CnHbQgpIn8DsrO0UPwxgPzQnNGXaJgLlrJrJ+55JamV448o66LdPWZAIWvq9YoXP+CsjfJOb7CjX8aZuhkvyQ9j7MYhI+5dlgB1V/CGndzZzOKh/m/RP6lkpnqyEzdkJgb3rskKaU5/g5hj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328444; c=relaxed/simple;
	bh=yeMVtIz8UUQKft9gRFxSjvPCVmPHSr7YvCj+PSfmwYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD/q1OV6OgHX8KXU+ULnRMqeqJt2JFlOeDs5nV9sJHBNNKanauiCEvfIXwCEPec369vL5UhTXGIOUYJF64kppqW8WRspD3R6JJCfYwBbhAKejGrDXU+3hE+uOl6xNzNosDWWgv3/DEVKjW5LAP2XwS3FFyY/2A9xuJ7ktbMQdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wMG7GcCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wMG7GcCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97B21F000E9;
	Wed,  2 Sep 2026 05:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788328442;
	bh=Kcxm313tBTZkBtttm3jkBxq622U7zwO4gbFDRZ2/uJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wMG7GcCkDCSGvGszseFg4D99JcLVmKP/0qPSl3C8ShxDWDGkgi9oAmTA4DNZW8fkI
	 iUBEAUx99VSBGUwWpoy1gN3Mfc/rYCGBKHsniesy1VwkGQOFyYNxB6cjPdlVGcpZz/
	 q5c0Wx01J1QbYDZ4k4KVplQqDSSA7j7n3RwpB3Mo=
Date: Wed, 2 Sep 2026 07:53:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Cc: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH] fs/ntfs3: validate target_attr in log_replay()
Message-ID: <2026090243-wilt-suds-f499@gregkh>
References: <20260901174934.6275-1-cenzhang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901174934.6275-1-cenzhang@linux.microsoft.com>

On Tue, Sep 01, 2026 at 01:49:34PM -0400, Cen Zhang (Microsoft Security FORGE Labs) wrote:
> log_replay() treats lrh->target_attr as a byte offset to an
> OPEN_ATTR_ENRTY in the open-attribute restart table. A valid offset is
> the table header size plus an integral number of entries. The redo
> lookup checks only target_attr < bytes_per_rt(oatbl); its earlier
> alignment check subtracts the header size without first checking the
> lower bound, so the subtraction can wrap.
> 
> The undo lookup has no table-bound check, and its earlier alignment
> check is skipped when lcns_follow is zero. Unlike the redo lookup, it
> also does not reject unallocated entries or NULL entry pointers.
> 
> A crafted $LogFile can therefore point into the table header, the middle
> of an entry, or past the table and trigger an out-of-bounds access.

Why not fix the userspace fsck tool instead?

thanks,

greg k-h
