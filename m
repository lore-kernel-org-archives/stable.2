Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384807;
	b=UagjpMAZz+jTu0DaJjKRGKJa06k6F7BgNZ9QCNmI/Suh3M3QuSoy3iRyuZ8Ka0teizGB
	 Db7IZa2gLLglGIubzAw7l3N0u9GbYcvEGEvLTJ90+EkojXey7lDbb60ST04PRPc6f6Dkc
	 0cNTWrubDtiacYIApXgM/JYcP4Pjfgh97L9FT2ecBXdq/9HeMUCEZskJhA9Z8JbPc0h64
	 GXQuFdFDFj6mPJO3hEe/Rwhdc+WnTx5S0x+p88bbDmdtc5kIwR3IrmSHJF7WHErj2MZjl
	 UioMrVxdW5zgTYQdQaoSk6hUx9pC2lil5R0Ti4hQC4GkdoVDXlZrcyk3IdSMYjkfYAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DgQI3xxkFFA7BhKNt2RfO4arKL4tKgGT+HlK8U19YZw=;
	b=kybLSjS4pZadzB8cw8bud0HMyATNNeoT+HiBZavcF241/KNlxGAQPF579vdai0d27kYP
	 YhCaHbVJr+RoNR0sqQG3YeEMS3mVMPX0PK1Dj2u2yehej6TORSt+dplkpGjcABDsdEGlA
	 a9xSDOMdJrxn3jRN+hXjqTWWPvgzmT/HtgGNFQvyPDX2rip1oaOqpU6KqVckOwjm9ZDO3
	 Mk44RP9mL4HAOO9UJ8VSrBDe3QRyTDJDE06orIQ4RP6rrC/9NtekOZpItVwsjNPagUf1v
	 TZM1SHqcRq08mrfvm7JlcxHfyOkHYVmixgP5qA1OVl1Z+UcWo2DwxqW7uN4gEv1CaVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=HFeXLgVM;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B79606A336
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B79606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=HFeXLgVM
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c499b5be0f1so1973566b.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794384804; x=1794989604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DgQI3xxkFFA7BhKNt2RfO4arKL4tKgGT+HlK8U19YZw=;
        b=HFeXLgVMBpTERHWDiSovZQXILqXdD0gpZ6s6i9Hv+LCjsrbc0lGXS/qto+UBNWe86X
         1XoFkqRfAiiGpWYmGh3xxPXoJqCMj/9maoc2qPS3CO2BwIHsp5XkD+MmV3Kl8KkWs6ls
         4MGbfG15/WA1l8grvJIBuLg5XmI1a7v7NnNkaZwV3Pd2gINGzmUkZoEkHP7c03qQ6AMy
         M7G8CGoF9Kl4dTAgt1NRKZCbbvzegKNWSb/4DoMlBbtNHyxtFdc5s6F/ysM0MA+nczOS
         0InufqTdtN9g/DKr2RXNzJJkTCf1lViyC+SE76K69X/IayGP0abaXc/0pwQ1ld3FI6R2
         AMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794384804; x=1794989604;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgQI3xxkFFA7BhKNt2RfO4arKL4tKgGT+HlK8U19YZw=;
        b=jj8eJtkr6TKUBEazL4FyJ9mh2XRI+PJzDD1dOOkoV8/Z+7vjqM4gZl7mZnaXLj7s//
         D4+fGedVuZVYhpXmsKFjQeTE21AIbrVQDeVkKDYVNQteV+/a1wLFqj+EQyFNQAUIEFb8
         cv0SaBHPe8kU8A4JVb8O3d8hR5rzRLJ6/68wu8euSUuK07d6VAepbT189MrYMteyEUNQ
         0EdKu6d1NrEmtyt7va5qJusy0qM1LsGTbCQqEy91e9WfzEEkbW9fcBia5Z4x2x9LjEqH
         V4e4l6R4U1NkX+TVfG2q4UvQIyNnriG7paTg9TOCct8zp7o1RlRKvXf9hdlluPo8jWyR
         ky+A==
X-Forwarded-Encrypted: i=1; AL+hErFIpWD79pzyEgJz8Vftlkq60OknL7bnE+03QCtsQ/r7DKS+TWg26TMgivg/b1L67MtnWaUVzos=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KZ9zG3eoZuAMjevFs6PL81xWCWCZU6qzcorxWmvTbw8jcWlBx
	TYvzDlq8E/OdOj0Bqz4ZP8CppwBunQFRrx0DLqWrhREvCrPwy7J+Qv+8Z2Lk98Yhi9s=
X-Gm-Gg: AYBFou342TSuvcCXH9ZqMYsmdM/8dI9zZmONKuq+ysGEFCEmc41TwaA6g8dMWGz0JqH
	ewc6iqZUYNMajyueHhMJXGVjyabWJcn8cddWDefRaStUTTmGalDJBwwfqFu6O2qupnuXayB6cG6
	YebQJ9sNFDwSAZhkH7N+SKP9I5LPfO0/JzOxCYHsHycrBA35V/RCVwdMVUnakFwa8PR31aIoBnS
	O5uY7t9cnTv6EvcTz6YKGNstQsscYoawBPjIHUC02KdpxYx4OezUL4nV9ND9AwV25CmbRtatfJ+
	oOzwQ6t/Hmg+8/CrOdrTTiYBCSwIo3ZiJUcYOgZX9IYU54ChbLp0K0p+bQhw/dWeDMpDtB06mWN
	Ccsz0sOgKDvzHK94uXtPy4TVx79OS/iSPtNjUldX1vadv8ILUnkJctNQRmv1soOceZZdaYd++ej
	bXwINWXfCBpyD6qAsqlL1qD4TuOSYjF7nLLcgpfiucGmNwkcofgyrLphOYgAMk5IBUHLXlj+vov
	SyAJPaOT9theHa7LCCR04AqsP0AcZu7TwsuPhyAsTgUsMHcMN01QXx2blie05YurDIzE32zinWD
	dzCta8/uoNoCF4GFf60OQ2t7KqLLmPJIGkY=
X-Received: by 2002:a17:906:3ce2:b0:c4d:1768:48eb with SMTP id a640c23a62f3a-c5066ae6ba4mr117518566b.2.1794384804465;
        Wed, 11 Nov 2026 00:13:24 -0800 (PST)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa1b27cdsm1775739b3a.19.2026.11.11.00.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 00:13:23 -0800 (PST)
Message-ID: <a5576744-0984-462f-8f85-aa71151b277c@suse.com>
Date: Wed, 11 Nov 2026 16:13:19 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix kernel BUG in ocfs2_page_mkwrite() when
 write_end fails
To: Zhiyuan Zhang <zhiyuanzhang912@gmail.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 yangwenfang <vicky.yangwenfang@huawei.com>, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+42984127d45ad96219de@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261111023444.22688-1-zhiyuanzhang912@gmail.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20261111023444.22688-1-zhiyuanzhang912@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 10:34, Zhiyuan Zhang wrote:
> From: Zhiyuan Zhang <zhiyuanzhang912@gmail.com>
> 
> syzbot reported a kernel BUG in the ocfs2 write fault path:
> 
>    (syz.0.17,5578,0):ocfs2_write_end_nolock:1945 ERROR: status = -30
>    kernel BUG at fs/ocfs2/mmap.c:106!
>    Call Trace:
>     do_page_mkwrite+0x147/0x310 mm/memory.c:3879
>     do_shared_fault mm/memory.c:6145 [inline]
>     handle_mm_fault+0x1a53/0x3750 mm/memory.c:6943
> 
> __ocfs2_page_mkwrite() calls ocfs2_write_begin_nolock() and then
> ocfs2_write_end_nolock(), and uses BUG_ON() to assert that the latter
> returns the full length.  But ocfs2_write_end_nolock() can fail: since
> commit 7f27ec978b0e ("ocfs2: call ocfs2_journal_access_di() before
> ocfs2_journal_dirty() in ocfs2_write_end_nolock()") it gets journal
> access to the inode buffer again, because the handle may have been
> restarted since ocfs2_write_begin_nolock().  That fails with -EROFS or
> -EIO once the journal has been aborted or jbd2 has seen write errors
> on the device.  The syzbot reproducer gets there by shrinking the
> backing loop device to zero with LOOP_SET_STATUS while writing to a
> shared file mapping.
> 
> Handle the failure instead of crashing.  ocfs2_write_end_nolock()
> leaves the mmap folio locked, because ocfs2_unlock_folios() skips it
> when w_target_locked is set so that it can be returned with
> VM_FAULT_LOCKED, and do_page_mkwrite() does not unlock it either when
> ->page_mkwrite() returns an error.  So unlock it and fail the fault;
> the faulting task gets SIGBUS, like for the other errors in this
> function.
> 
> For an mmap write ocfs2_write_end_nolock() returns either len or a
> negative errno: inline data has already been converted to extents by
> ocfs2_write_begin_nolock(), and copied is equal to len.
> 
> The BUG matters for local mounts, where the filesystem is expected to
> go read-only and keep running after a journal abort.  On clustered
> mounts ocfs2_abort() panics the node anyway as soon as it notices the
> aborted journal.
> 
> Fixes: 7f27ec978b0e ("ocfs2: call ocfs2_journal_access_di() before ocfs2_journal_dirty() in ocfs2_write_end_nolock()")
> Reported-by: syzbot+42984127d45ad96219de@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=42984127d45ad96219de
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5-2
> Signed-off-by: Zhiyuan Zhang <zhiyuanzhang912@gmail.com>

looks good to me.
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
> ---
> 
> Notes:
>      Testing: syzbot C reproducer in QEMU (x86_64) on a defconfig-based
>      kernel with KASAN, lockdep, DEBUG_VM and hung task detection enabled
>      (not syzbot's own config).
>      
>       - Unpatched: BUG in 3 of 3 runs, within 22 iterations.
>       - Patched: 437 iterations over 3 runs hit the failing write_end 21
>         times (11 x -EROFS, 10 x -EIO), all ending in SIGBUS, with no BUG,
>         KASAN, lockdep, DEBUG_VM or hung task report.
>       - Negative control: without the folio_unlock(), inode eviction hangs
>         on the locked folio in truncate_inode_pages_range() in 3 of 3 runs
>         that hit the error.
>      
>      Not tested on a clustered mount.
>      
>      AI assistants were used to analyse the report, to write the patch
>      and the changelog, and to run the tests above.
>      
>      ocfs2_dio_wr_get_block() has the same BUG_ON(ret != len).  It is left
>      alone here because the pending "migrates ocfs2 DIO from buffer_head to
>      iomap" series removes that function.
> 
>   fs/ocfs2/mmap.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
> index 6c570157caf1..1c03f45e8965 100644
> --- a/fs/ocfs2/mmap.c
> +++ b/fs/ocfs2/mmap.c
> @@ -103,7 +103,17 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
>   		goto out;
>   	}
>   	err = ocfs2_write_end_nolock(mapping, pos, len, len, fsdata);
> -	BUG_ON(err != len);
> +	if (err != len) {
> +		/*
> +		 * ocfs2_write_end_nolock() keeps the mmap folio locked so
> +		 * that it can be returned to the VM with VM_FAULT_LOCKED.
> +		 * On failure nobody else will unlock it, so do it here.
> +		 */
> +		folio_unlock(locked_folio);
> +		mlog_errno(err);
> +		ret = vmf_error(err);
> +		goto out;
> +	}
>   	ret = VM_FAULT_LOCKED;
>   out:
>   	return ret;
> 
> base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620

