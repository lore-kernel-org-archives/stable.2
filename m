Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F61A6829;
	Fri,  3 Jul 2026 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042533; cv=none; b=OFMD5pGRwM8zE8cOF8eEHRhPzGHhBKbm8j4CDMHziyF7hDfbjOhROy0jJU7jdy8eAm3DKgv2ltpDOSkxd0ab5liRPkZfWd72VnONWzmhvoNnWzQJLnDnRti2M38tCRDHGOipgC4TSa3cePrg9Mh35MzHmwNQ0re2h5iP2CYMPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042533; c=relaxed/simple;
	bh=9y9Knjmaq3UbsqRd5XMzgtWRAg4wNyXhFTMUYoeKe04=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=cvgO7VcNOulWKDV1lZ3h1xXipUuDi/e8MHC6TeU9iVgFABnqfEdP+q1avDmjh2lQQmwae8QNbIrtNLxEZfaVnWRlT9Ck0OUGXNXllRmuG/ycboGZ0WmtlFQUi5xH6nrXkyFZUlEkFkKO3wTrji6QU9GwJf0hrGNpd4ui7pF2Mp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BGH5pXag; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BGH5pXag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=+sGC+Dwc9ai0ghaJ2Gg4nS8CYYSVLp7XjSXbJUX3ia4=;
	b=BGH5pXagpO9i+ir0zHR/nVsRceGactCppfMSgIncj6Uu2IJu8YKEOhZsAkEe4A
	VDPiOmS9Ne+xi+0w5D8/ltxT5S/tYiP1dA04z0OL1RLmqOYPvv2rU0g9+okPRw/I
	Y5tHPGdlsyHG4TxM2ClzXSEYRVFLcJ2vxdihKByspCd38=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3vxbKEUdqYXh1Cg--.64035S2;
	Fri, 03 Jul 2026 09:35:07 +0800 (CST)
Message-ID: <6A4711BE.8090101@126.com>
Date: Fri, 03 Jul 2026 09:34:54 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Namjae Jeon <linkinjeon@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ntfs: prevent write access to $MFT inode
References: <20260702090627.137915-1-zenghongling@kylinos.cn> <CAKYAXd9018ondtRRa6mGexej-SDCm3-LeWV0W4TCUwBZ5hOXvg@mail.gmail.com>
In-Reply-To: <CAKYAXd9018ondtRRa6mGexej-SDCm3-LeWV0W4TCUwBZ5hOXvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vxbKEUdqYXh1Cg--.64035S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4fWr4fZr18KrW7GrW3Wrg_yoW8WF4fpF
	W2gFy5KrWYq3yxAas7X3WkAF1Yg398try3Gr1UKrs3ZasxKF1jqFW0gry09a4Iyry3Jw42
	vr4j9ryxXw12yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-3kAUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrwvis2pHEcvvZAAA3J

   Hi Namjae,

   Excellent solution! Your S_IMMUTABLE flag approach is much better 
than my function-level checks.

   I've validated that your patch comprehensively blocks all attack 
vectors:
   - write(), truncate(), fallocate(), mmap() - All protected via VFS layer
   - Single modification vs. multiple function checks - Much more elegant
   - Zero runtime overhead - Performance efficient

   Your insights about the $Bitmap deadlock issue and directory handling 
show deep understanding of NTFS architecture.

   This solution would also make excellent patent material - the 
VFS-level protection mechanism is both innovative and effective.


   Best regards,
   Hongling Zeng

在 2026年07月02日 20:12, Namjae Jeon 写道:
> On Thu, Jul 2, 2026 at 6:06 PM Hongling Zeng <zenghongling@kylinos.cn> wrote:
>> Malicious NTFS images can expose $MFT to userspace and allow write
>> operations, leading to potential kernel NULL pointer dereference
>> since ntfs_mft_aops lacks write_begin support.
>>
>> The vulnerability affects both write_iter and mmap-based write paths:
>> 1. write_iter path: ntfs_file_write_iter()
>> 2. mmap write path: ntfs_filemap_page_mkwrite()
>>
>> Without protecting both paths, attackers can bypass single-path
>> protection by using the alternative write method.
>>
>> Fix by adding write protection in ntfs_file_write_iter() to prevent
>> any write operations to FILE_MFT.
>>
>> Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Can you check if the attached file fixes this issue ?
> Thanks.

