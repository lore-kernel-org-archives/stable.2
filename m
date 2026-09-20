Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023193DDAFD;
	Sun, 20 Sep 2026 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789903560; cv=none; b=ckUJ0uEnuMlNP3zF/0rPBIWBEX9ZE9CtpepftWKOqLoKqKw26ROvYWKvbYQQcy1EdN1j/uQu59YGrcLXPe+Xthlu/Fue3fz61+dEEExgAd6Grof7EMuFzYYvDCRuskGo56OX8H/vJFKp7qDGTXOGWcuCzpt39E/eFDm5dFHJJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789903560; c=relaxed/simple;
	bh=jmhPB1P9jGwQfWomRnGhe0RB+DrGmw+jS55nZI7L4fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/WsDoW4225VcmWyrMEfMKUYNwdracWq8DafVz8nGe9PfRfbHske9TDH8p1RVZqQVNiICZ2K6Deh1qRB2zavUOHHNSh15Mu3tJfwv25i/WCZfHjmb46q1Z3jphM+vmMEq1hXOEsMA+Z3pzTRjc9LhlHg7pZnv3IS6C4ThHDAXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SqSmlg4r; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SqSmlg4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AM+FarV7xB7Zz+QiLT9L6i+YPz8fUNu/gX+M5rzQES4=;
	b=SqSmlg4rYqRU6fBU7461E5izVzhx12E1NLQpaEAQRBY3MxLO0wOKm5gIYgaHF3
	Mn8ylT4HtMUwpGV/oWO78CjqGw/i3cIjH9rEZOQC0NlnIiA7I/nbFdhGT1GyPs6M
	pc8qNT8Ed0efLtpjkxj+CPtHpH3bHK+Bmz6A77q1PpZSU=
Received: from [IPV6:2409:8900:1ee3:222c:6d18:42cb:3228:5708] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHlnuswq9qwud7Bw--.60149S2;
	Sun, 20 Sep 2026 19:25:34 +0800 (CST)
Message-ID: <04255390-4133-4e8e-81ad-4d2402498431@163.com>
Date: Sun, 20 Sep 2026 19:25:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ntfs: mount hibernated volumes read-only regardless of
 errors=
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260920025955.31209-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260920025955.31209-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHlnuswq9qwud7Bw--.60149S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw13tF1xuw1xtF1DKr4rKrg_yoWfKr4Dpr
	Z7Kwnxtr4ktr1a9rn2yayxG3WF9rZ2yF4jgr18Aw4xZrn8Jr13tryxKw4Y9a4Skr98tw48
	XF4j9343WF4DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfOz3UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6g5iLWqvwq4eDwAA3T



在 2026/9/20 10:59, Hongling Zeng 写道:
> The hibernation check in load_system_files() only converts the
> superblock to read-only under errors=remount-ro.  With the default
> errors=continue (and with errors=panic), a hibernated volume is
> mounted read-write and the mount-time $LogFile emptying writes to it,
> although a hibernated volume must not be written to at all.
> 
> Drop the on_errors term so that a hibernated volume, or a volume whose
> hibernation state cannot be determined, always mounts read-only.
> NVolErrors() is still recorded, so ntfs_reconfigure() keeps refusing
> remounts to read-write, and the $LogFile emptying is skipped by its
> !sb_rdonly() check.
> 
> The check itself must not apply the errors= policy either: it runs
> before SB_RDONLY is set, and ntfs_lookup_inode_by_name() and
> ntfs_iget() call ntfs_error() internally on corruption or I/O errors,
> which under errors=panic would panic the machine before the read-only
> fallback has made its decision.  Run the check with the super block
> temporarily marked read-only, which makes ntfs_handle_error() ignore
> any ntfs_error() issued on this path; the super block is not
> published yet at this point, so the temporary flag is not visible
> elsewhere.
> 
> Restore read-write access only if the check succeeded and no errors
> were recorded earlier during the mount, e.g. when loading the LogFile,
> so that a volume with recorded errors stays read-only, matching what
> ntfs_reconfigure() enforces for remounts, and a message is logged for
> that case.
> 
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
> Change in v5:
>   -Rework the errors=panic handling per review feedback.
> ---
>   fs/ntfs/super.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index f4a73e45773d..ab91cd1a8515 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1398,6 +1398,7 @@ static bool load_system_files(struct ntfs_volume *vol)
>   	struct ntfs_attr_search_ctx *ctx;
>   	struct restart_page_header *rp;
>   	int err;
> +	bool temporary_ro = false;
>   
>   	ntfs_debug("Entering.");
>   	/* Get mft mirror inode compare the contents of $MFT and $MFTMirr. */
> @@ -1572,8 +1573,20 @@ static bool load_system_files(struct ntfs_volume *vol)
>   	 * NVolErrors() without setting the dirty volume flag and mount
>   	 * read-only.  This will prevent read-write remounting and it will also
>   	 * prevent all writes.
> +	 *
> +	 * The check runs with the super block temporarily marked read-only, so
> +	 * that ntfs_error() calls issued internally by ntfs_lookup_inode_by_name()
> +	 * and ntfs_iget() cannot trigger errors=panic before the read-only
> +	 * fallback has run.  The super block is not published yet, so the flag
> +	 * is not visible elsewhere.
>   	 */
> +	if (!sb_rdonly(sb)) {
> +		sb->s_flags |= SB_RDONLY;
> +		temporary_ro = true;
> +	}
>   	err = check_windows_hibernation_status(vol);
> +	if (temporary_ro && !err && !NVolErrors(vol))
> +		sb->s_flags &= ~SB_RDONLY;

Hi Hongling,
   Thanks for sending the updated patch. I'm sorry, but while reviewing 
this version more closely, I found a problem with the temporary 
read-only approach I suggested during the v3 discussion.

   The condition above does not reliably establish whether read-write 
access can be restored. An ntfs_error() call does not necessarily set 
NVolErrors(), and some errors reported by nested helpers are not 
propagated back to the hibernation check.

   For example, ntfs_attr_readall() can report "Invalid attribute data 
size" and return -EIO without setting NVolErrors(). If this happens 
while reading the optional WSL extended attributes through 
ntfs_ea_get_wsl_inode(), the error can be ignored and inode loading can 
still succeed. If the hibernation header is otherwise valid and 
zero-filled, the check can then return zero.

   With errors=remount-ro, the original code would retain the read-only 
state set by that ntfs_error() call. With v5, ntfs_handle_error() 
returns immediately because SB_RDONLY is already set, and the condition 
above can subsequently restore read-write access because neither err nor 
NVolErrors() reflects that error.

   This makes it difficult to define a reliable restoration condition 
using only the check's return value and NVolErrors().

   I now think a better approach is to temporarily replace 
ON_ERRORS_PANIC with ON_ERRORS_REMOUNT_RO around 
check_windows_hibernation_status(), then restore the original policy
  immediately afterwards. This covers both direct and nested 
ntfs_error() calls while preserving any read-only transition they 
trigger. The temporary substitution leaves the existing errors=continue 
and errors=remount-ro policies unchanged.

   This deliberately falls back to read-only for any ntfs_error() that 
would otherwise trigger panic during the check, including recoverable 
errors. I think that is a reasonable conservative fallback: it avoids 
panic without treating every such error as a persistent volume error by 
automatically setting NVolErrors().

   If the check reports hibernation or fails, we would still 
unconditionally set SB_RDONLY and NVolErrors(). We would also retain 
your protection for volumes with errors recorded during the check or 
earlier in the mount.


   The following is a replacement patch against the same base as your v5:

   @@ -1398,6 +1398,7 @@ static bool load_system_files(struct 
ntfs_volume *vol)
    	struct ntfs_attr_search_ctx *ctx;
    	struct restart_page_header *rp;
    	int err;
   +	u8 saved_on_errors;

    	ntfs_debug("Entering.");
    	/* Get mft mirror inode compare the contents of $MFT and $MFTMirr. */
   @@ -1572,8 +1573,18 @@ static bool load_system_files(struct 
ntfs_volume *vol)
    	 * NVolErrors() without setting the dirty volume flag and mount
    	 * read-only.  This will prevent read-write remounting and it will also
    	 * prevent all writes.
   +	 *
   +	 * Nested lookup and inode-loading errors must not panic before the
   +	 * read-only fallback.  Temporarily use errors=remount-ro instead of
   +	 * errors=panic, preserving any read-only transition even if an error
   +	 * is not propagated or recorded in NVolErrors().  This is safe during
   +	 * initial mount, before the super block is published.
    	 */
   +	saved_on_errors = vol->on_errors;
   +	if (saved_on_errors == ON_ERRORS_PANIC)
   +		vol->on_errors = ON_ERRORS_REMOUNT_RO;
    	err = check_windows_hibernation_status(vol);
   +	vol->on_errors = saved_on_errors;
    	if (unlikely(err)) {
    		static const char *es1a = "Failed to determine if Windows is 
hibernated";
    		static const char *es1b = "Windows is hibernated";
   @@ -1581,12 +1592,15 @@ static bool load_system_files(struct 
ntfs_volume *vol)
    		const char *es1;

    		es1 = err < 0 ? es1a : es1b;
   -		/* If a read-write mount, convert it to a read-only mount. */
   -		if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
   -			sb->s_flags |= SB_RDONLY;
   -			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
   -		}
   +		/* Hibernation safety takes precedence over the errors= policy. */
   +		sb->s_flags |= SB_RDONLY;
    		NVolSetErrors(vol);
   +		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
   +	} else if (!sb_rdonly(sb) && NVolErrors(vol)) {
   +		/* Match the read-write remount restriction for recorded errors. */
   +		sb->s_flags |= SB_RDONLY;
   +		ntfs_error(sb,
   +			   "Errors were recorded during mount.  Mounting read-only.  Run 
chkdsk.");
    	}

    	/* If (still) a read-write mount, empty the logfile. */


   Sorry again for overlooking this issue in my earlier suggestion. I 
believe this approach is more robust because it never clears SB_RDONLY, 
so it does not need to reconstruct whether a nested error should have 
made the volume read-only. The policy change is limited to the 
hibernation check during initial mount, before the superblock is published.

   If you agree with this approach, could you please incorporate it and 
send another revision? I'd appreciate feedback from you, Namjae, and 
Hyunchul.

feel free to add:
Suggested-by: Baolin Liu <liubaolin@kylinos.cn>

Thanks,
Baolin.







>   	if (unlikely(err)) {
>   		static const char *es1a = "Failed to determine if Windows is hibernated";
>   		static const char *es1b = "Windows is hibernated";
> @@ -1581,12 +1594,25 @@ static bool load_system_files(struct ntfs_volume *vol)
>   		const char *es1;
>   
>   		es1 = err < 0 ? es1a : es1b;
> -		/* If a read-write mount, convert it to a read-only mount. */
> -		if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
> -			sb->s_flags |= SB_RDONLY;
> -			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> -		}
> +		/*
> +		 * A Windows hibernation image is not a filesystem error, so
> +		 * this is a safety interlock rather than something the
> +		 * errors= policy may downgrade.  The super block is already
> +		 * read-only here: the temporary flag taken for the check
> +		 * above is not restored when the check failed.
> +		 */
> +		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>   		NVolSetErrors(vol);
> +	} else if (unlikely(temporary_ro && sb_rdonly(sb))) {
> +		static const char *es1 = "Errors were recorded during mount";
> +		static const char *es2 = ".  Run chkdsk.";
> +
> +		/*
> +		 * Errors were recorded during the check or earlier, e.g. when
> +		 * loading the LogFile.  Stay read-only, like ntfs_reconfigure()
> +		 * does for volumes with recorded errors.
> +		 */
> +		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>   	}
>   
>   	/* If (still) a read-write mount, empty the logfile. */

