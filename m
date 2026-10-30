Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343734;
	b=r11y7hTsP8SiLn07nGFU/uArS7o/LN7iW3AklemN+lZZ778XGQZxQA8N1NmAV8r41LKF
	 gdbaCXUIc2cqkXW2XB+nrjb5/QGJl3SpRZ+8gkDLbDUcyGhbAr7ViZSJEzdQV7qOdDlZa
	 wWzNQnQ4Og4Zy4gRqQwxe9pKeYIaiJsdYWPqip3Ujcj4tMhdnASkmfUhMmdTkJlh2AzYy
	 Pm1DAV8KYeUmHSDzG3A3qOvvXwVFJpijQus1vqVjvWaHhrZnqCjPx2Fa77jT4f2aVKIKr
	 JwMO/zZqwVz5z20azCj8BZHJjT/81eIyUvDjg2MTNpFCtUum+aT7F6Um9930G+OlGqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ogr3bCQsBHWeawLHi45mAgAy8w/Vyf5t319SCZZaenM=;
	b=iIMpleuSEuR0ShBTD7/WNgjDBBf57hMaaH4bkzFd2cUmiQSVMpxCPf/Tny3v3MaVXII2
	 q5d4lJ+kLAjSaeVs/U5FI8U+1T/9sBmBby1VUIZPwnJKgVFvJRvANQuIhTBvfPFLXNOVC
	 TOajA4/NjuCLirzkkkogqvfr5oLSR/y5Jxu1qLUL/20dD9vQirEuZpHAgeoL1pUzFVuur
	 7nsSSlZQOanKDNHq0cLNgOI7hy5ZDl6XitFsrKHQ8bIroKc2tkyEcs9e/roFs5XDcRvzF
	 6/OL3j+08I+eOW6TAJXHlj1I41EDoxiEOay0WDmjvpQ41YwDegt++Q7E6FJuyuPyKfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LhkM47a+;
	arc=none smtp.remote-ip=74.125.230.71
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C10606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C10606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LhkM47a+
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-3ac5c86570aso118511fa.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793343732; x=1793948532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ogr3bCQsBHWeawLHi45mAgAy8w/Vyf5t319SCZZaenM=;
        b=LhkM47a+yCJ5/iDQ4+9TPEDbwfnW1lr4HeNrzJIP10tyD7EDlVosdGsRykztV/svKr
         fITtZQ1OM6OhMEsnbL5e6NWIr1998/Cvo86jtbThjWx2UAIkTFgnffqLg+NiDQnZDXPZ
         znHGWNg43I3wgL+rMKw8b5mAmOgOsFrDITdm6pJcj4+RBi3YSvu2rAe1XF+oY6h6OQia
         6a9w3gtmEDHR7+n3vvBn9JRTXFO8+8RcOiNPFnMwlXMggZSBkwszMoATKEEd91NpIAh7
         eYoaqRmeTzVp9ifvRP84BfqMM4Fz0H5GDpGEe+ieNk794AUlPLHiIzPju1nidObdORY+
         cW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793343732; x=1793948532;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ogr3bCQsBHWeawLHi45mAgAy8w/Vyf5t319SCZZaenM=;
        b=J8gHQ3kks9OyD7DbKIXgmf6PT9MDTQlyeLxKM5zJ7fYwZRjxwX261t7FQRG93f/qSF
         zYg6v3vTkCMSYJ7Xyq1xUgeFCJVXgWaVaozFuw5GY2EsH+QMerJgSyJHYfGHxWq+A6ni
         aK2oVpFIZ5xvI+3uOmKCD+++jmoXEsAclUHzqHc0X3wGNK0O79gNhAtnDVseuW1Ve5F+
         7ahK4MwaV4aazoPgBurlEzGlOkjj1FoAIONR7ZmEARdCVQ/wJ4CxzVuahmfDuenXerLa
         rVO+dwVCP/XWyoJjyWzjO0floQo7Q/XZTB5vb/eEdDpJQXByjUQy5p1lYake7MHsM5ag
         Gkvw==
X-Gm-Message-State: AFq9FYJf7w9ivMyJMKgqzcDfyij+6z5Umyc44hQoSzyvp8uxvgxoRB0E
	zbhYdZnFC+QNPdlPTVQsCQHX8BC8i8MiIv0cYGc1xo6noeHaMRZnk+QJ8Pu5V6sR
X-Gm-Gg: AYBFou1quiakY6kpw7/FFC7pE8DIuZg55PDnOgkvBGBrUDpWtIsy243qTmsJMykO8bp
	nE7BKDhLpOXsY8v+W6YSz3y+XOcRELA6+5FYAYzKPRy0uD/V5Vm9xrRD8RrjHMRVWXCc7PBYKa2
	6uVqNqO/Evv8sHVvEyFkbJngZlwFdChxu4HDinfFvNPEU+745dUBO1Y9FBtpBjZUnCuwYRcS4Jh
	JgC+DDMOuPkOgxemuiMyPlw8Z43QLJ9/u4QebXw4VGEpg7p/8xjQ6lNEb/mATNU6vnkrpB3mPc5
	jMXiuk/fkBjnEA+PE8C2AB+26q/hY7JB1Qcw7oVo6j/rrHRCENG09QuJkz6j3xF+nf+gJMEUuM+
	b955Bwf5kO22odmVf2FbKP69o/1PnPaVDYSl25otiRwPp0/zp2mB1yVfKOV/cteW2fnaW6wRzPw
	fDdMFtajK98Ju3Y5Ir4MpcOaDDzGtXS7BbyR5+iiveMClHze3ep9CHhk1uokrE544Ok88tjz9h9
	DIfs5Gw61l3Q7fZCRFa7PqhkOLvZ38nDlRhu/h7/hzjMPObxdk84XH4QcoOU/I4s/tc2VhOn+lw
	5W6RvW7u7qS+5pvEX7ExpDiV2Rg50ukVTcwXsI7OCt0qUZfwerRKb90VVC+AxqdjnUA=
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id 38308e7fff4ca-3acb7aa83b1mr2253181fa.13.1793343731854;
        Fri, 30 Oct 2026 00:02:11 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbf31c35sm1413961fa.36.2026.10.30.00.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:02:11 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mike Rapoport <rppt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Mike Rapoport <rppt@linux.ibm.com>,
	Yongqiang Liu <liuyongqiang13@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15/6.1 v3] ARM: 9359/1: flush: check if the folio is reserved for no-mapping addresses
Date: Fri, 30 Oct 2026 10:01:51 +0300
Message-ID: <20261030070155.9857-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yongqiang Liu <liuyongqiang13@huawei.com>

commit 0c66c6f4e21cb22220cbd8821c5c73fc157d20dc upstream.

Since commit a4d5613c4dc6 ("arm: extend pfn_valid to take into account
freed memory map alignment") changes the semantics of pfn_valid() to check
presence of the memory map for a PFN. A valid page for an address which
is reserved but not mapped by the kernel[1], the system crashed during
some uio test with the following memory layout:

 node   0: [mem 0x00000000c0a00000-0x00000000cc8fffff]
 node   0: [mem 0x00000000d0000000-0x00000000da1fffff]
 the uio layout is：0xc0900000, 0x100000

the crash backtrace like:

  Unable to handle kernel paging request at virtual address bff00000
  [...]
  CPU: 1 PID: 465 Comm: startapp.bin Tainted: G           O      5.10.0 #1
  Hardware name: Generic DT based system
  PC is at b15_flush_kern_dcache_area+0x24/0x3c
  LR is at __sync_icache_dcache+0x6c/0x98
  [...]
   (b15_flush_kern_dcache_area) from (__sync_icache_dcache+0x6c/0x98)
   (__sync_icache_dcache) from (set_pte_at+0x28/0x54)
   (set_pte_at) from (remap_pfn_range+0x1a0/0x274)
   (remap_pfn_range) from (uio_mmap+0x184/0x1b8 [uio])
   (uio_mmap [uio]) from (__mmap_region+0x264/0x5f4)
   (__mmap_region) from (__do_mmap_mm+0x3ec/0x440)
   (__do_mmap_mm) from (do_mmap+0x50/0x58)
   (do_mmap) from (vm_mmap_pgoff+0xfc/0x188)
   (vm_mmap_pgoff) from (ksys_mmap_pgoff+0xac/0xc4)
   (ksys_mmap_pgoff) from (ret_fast_syscall+0x0/0x5c)
  Code: e0801001 e2423001 e1c00003 f57ff04f (ee070f3e)
  ---[ end trace 09cf0734c3805d52 ]---
  Kernel panic - not syncing: Fatal exception

So check if PG_reserved was set to solve this issue.

[1]: https://lore.kernel.org/lkml/Zbtdue57RO0QScJM@linux.ibm.com/

Fixes: a4d5613c4dc6 ("arm: extend pfn_valid to take into account freed memory map alignment")
Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Roman: folio_test_reserved() replaced by PageReserved() because
commit 8b5989f33337 ("arm: implement the new page table range API") and
folio infrastructure are not backported to this branch. ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2024-26947

 arch/arm/mm/flush.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 6d89db7895d1..ef848bf0df28 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -280,6 +280,9 @@ void __sync_icache_dcache(pte_t pteval)
 		return;
 
 	page = pfn_to_page(pfn);
+	if (PageReserved(page))
+		return;
+
 	if (cache_is_vipt_aliasing())
 		mapping = page_mapping_file(page);
 	else
-- 
2.53.0

