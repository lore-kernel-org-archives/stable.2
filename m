Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205411;
	b=PSWFzg7BuWNYuS8MNRnxFCOg0JoN3VW5+KeT9//u/fHrZCzNH038yvRWlzW/PqHsoNha
	 oCbj0EzWumBoLDHs9wzo7EAqp1qmAB3FpEKzfVkvE0MNKSTlg5/8NFK+vP2YUMTj8+Wzh
	 wiL7LqnOOQ48XthaZ3EL+XpRxLwUfZEVnm1yXATDTBf4fGG2tf0KGyirTesP+jhd3RvlG
	 IuGSCMsNslf/ApsLA7RHeO3ruua8YpapDaJD3hXdpAN5FYnkExOfzKxal7BPNFVL33sq3
	 pa/PZ65DBZfq1nhDuwiY5H+GeHLUy4Zmv6OtsokBs1RIArxdjekHLxtjwx5k7LBvvvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M68LbjcTJ3E++0vyBdIVrjiqmT6srx4BEI+V4obs4pE=;
	b=ACRi5Gb+iCsXG0gceFeOEXrRTG6XfIOxFNC3q97zr3j5XvEGxq7AzTPjVzCvsghzKhC6
	 ScJ036VoiITKWatn+1FCe4Lf1Y4sJ65JmoF0Mb1jEYI11yPs9lL9WC+DyyS3m7YqxIm/x
	 7LXEi9LpcjCLE9kCK2OQsobp6iKZDIk2YHjSKbtiJtiQrpJVqfMdIB7WylAdNdka6T7j4
	 IETATGddaAaEfU+0B06TOwMmRt4ksZIRKHsg/v+r8Ls4L55JADaIADXdVZATmtAZt4F79
	 dLpeBLmvHqqRlDyv3JLGTshFmT3b0Pfh+EH2VuhrSiBhtxLSTZJoDGsrYch7kNIZt8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Gg5LX1qX;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0068D606A6C8
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0068D606A6C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Gg5LX1qX
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-380b40319bdso1690465eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795205407; x=1795810207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M68LbjcTJ3E++0vyBdIVrjiqmT6srx4BEI+V4obs4pE=;
        b=Gg5LX1qX17VWmImDXwcPSGRir+9pe3muYHdBXXn2TQZBLaax2P5BdibC66jKqm8gXj
         wPaxIl7kqPOBeGHU41R9p9i4a8Vko4bRLscP3RcRlM8AP79jbI/epFFZKM9YeqtMcKfP
         ep9AaCBVX+senmrCXWT5t/PVACubiiShEmjkVFxMK1EIqnWdMQqJPGdsPdYI14SwXEED
         SkcrTKBu+2jku7MZxtBytLDxWEWhCEBjaYULCLysORczlS0sgw6kLKnjOjS7OjPH6Ub8
         zPxjODqEY5YKdEpT9gfUveoR7keIfRLvgKwas334lsYQ8ciBqybX9euPEl+qxVwi2qxK
         VlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795205407; x=1795810207;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M68LbjcTJ3E++0vyBdIVrjiqmT6srx4BEI+V4obs4pE=;
        b=QJcUlRQ1VzmfiDSkFPqFKLhKZYNCodluHfPoyqA+D1NkyTw4B5c/MMLy04/raRpXtH
         mbLuYdvrz9YMkODbhBX25FTfvuqb2oMfiuuBbYzAp+od/hddrRTjpJUT5dOtO3Z9yyQo
         MZUuf8dyogNpFkkctqEnt8G3pFDHuM8NTay7YJTpHEhnKnNt2tgSV+RteYZPTeTmSyEn
         8NNts/CUXA5E56Xs78zqfwVtjBSovbXD8EcgbgBCRwB4Xp9LJphB9VgPEKkymnyyq527
         yAQXK2TNxTH6YAxwaNwMU7AYlN1b9jvQUpVPxcAbXFegI89etw4OIzgOEzf5IcbA1XlF
         qaLQ==
X-Gm-Message-State: APuU4Z8xwOj2hjdqCDOE+WlRKn9cpbxoHa3QZXMblS/6DCpjMCEzX2P3
	U61eVLK4+F3MRw+ZGbR53cKN9WLNmxLruQjRvJld/1EnN3IwXPc3mqERnenTbegmj8MTm6tZa61
	8B92W
X-Gm-Gg: AYBFou05f4aGKfNowaKRJmAO5H4otsBgj2o6b7nowsw2DwZyYDTa8snB7Vrxv44JSp4
	MDOm2ZbYCw1r61/ZH2Kwt51F3YGpD+LLNbLGtDRuQcaBuxuaijKMLKrpiFbB82cJUP9udYkIO3r
	PscYF+suUkgNbeHb8fV63RjtbuEt0UhZLNB5zr+CO60MwYV+8qWr2rXTrkGNS8G9Q8K9fb6WkIv
	YjNOQsPs6ZKolceYusvAyV64i6vyPOt+Dxb40b+CcbjTtWh4j/XF2om5bFMlG9GpCWuJhTaj4Y0
	T20C2A0TVBcoXNG1WPyOakfyHUrrabBNqCZdGfn5RTsfq8YxhHD+xbUc5k8OGgih8I4ddZzaaJk
	NxenweQV1NtiznC6OwsjSyhNoIW0j2s/PgbP3Sgb05VA63Pjnnr8PIZS0KmfDh3QVP1P8QXI0cJ
	w3nGAvbSXzof+KpBAJbmKVNwFuPhewhdluf5OytR/5zYDqWzyJDpXxR/11FuIz1dqj/ikPokw0I
	BsUIZJrU4YEVK5DybSub0bz19HfCRYgZgg8LWg7gJF8+3lYQpAV7cl25MfehXEVurndM3CKS4Tc
	H2d/tcWzAtKNRogU52R7gzlTykanFWhspcZ7leQGy/+oRDGbZTR+bftgpksVZH+VAYnvAi/Ucsj
	L0c7AzWbZfaa6/HmJqhqVcOY=
X-Received: by 2002:a05:7300:88:b0:386:959c:11ac with SMTP id 5a478bee46e88-386959c141bmr1391312eec.6.1795205406871;
        Fri, 20 Nov 2026 12:10:06 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:dd51:675:4b81:7ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm8771267eec.25.2026.11.20.12.10.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 12:10:06 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	mlbnkm1@gmail.com,
	simona@ffwll.ch
Subject: [6.18.y] Please pick three fbdev mode-sysfs fixes
Date: Fri, 20 Nov 2026 15:10:03 -0500
Message-ID: <20261120201003.42046-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Please pick these fbdev fixes for 6.18.y, in this order:

  d15d51fb26e830af58f3f21964f1c09c239077ea (CVE-2026-80580)
  ("fbdev: bound mode sysfs output to the sysfs buffer")
  95e647d2a5304a8fd11f1ba3c8502de700650131 (CVE-2026-80579)
  ("fbdev: clear fb_info->mode before deleting a videomode")
  061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2 (CVE-2026-80785)
  ("fbdev: serialize mode sysfs access with lock_fb_info()")

They bound the modes output to the sysfs buffer, clear fb_info->mode
before its modelist entry is freed, and serialize the mode sysfs readers
and writers with modelist replacement in store_modes().

The fixes were tagged "Cc: stable@vger.kernel.org # v7.1+" and are so
far only in 7.1.10/7.1.11 and in mainline since 7.2. The affected code
is older: the CVE records list all three bugs as present since 2.6.12,
and 6.18.64 has the same unlocked show_mode(), show_modes() and
store_mode() paths. If the v7.1+ limit was intentional, please let me
know and disregard this request.

The prerequisite, upstream commit 6f611e5e5f33 ("fbdev: Wrap
user-invoked calls to fb_set_var() in helper"), has been in 6.18.y since
6.18.57. All three fixes apply unchanged, in order, on 6.18.64, and no
patch currently in queue-6.18 touches the same files. 6.12.y and older
stable series lack these fixes as well; this request covers only 6.18.y.

Compiled drivers/video/fbdev/core/fbmem.o and fbsysfs.o on 6.18.64 from
a cumulative x86_64 tree using allmodconfig. No kernel boot or runtime
test was performed.

An LLM was used to check applicability and stable-queue history and to
draft this request; I reviewed the result.

Thanks,
Artem Dinaburg
