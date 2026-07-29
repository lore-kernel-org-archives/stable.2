Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D14119F3;
	Wed, 29 Jul 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341863; cv=none; b=jK9PJQzqJIN5y8q6ID11Vrv4nJm9fc9xhG63q8dJYaBqkPrzIzkmbBKhPKb8QaJAabj28Vd3sLYrUkJATMXTjCEh6L3x7u839aFW7e5u4Povwcy0mKaK8QsY3xbZ0C30lN+36XTryn2vHy1EHfb4MIRM91GAx28p/teJHHe+ov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341863; c=relaxed/simple;
	bh=84FO30WUjmV3PiK+OMYNtHVQWQvRVx2zgzSP5W3cWFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoTBoGYXL2JeRD06zq1LE4SEkpeJ2MBQxvhF+WMo6mzm3RD1eYv3uCRdHOLjQip5CCk/y/19FYWqVkIHMa/gqGQVaT4ump52htReL0GbXsVGT5AE9MJDE4ZWtkdjWHA4bsn1ndGosIHTdAQ0P5OOJdW4Sc/WyfZjtrXI6N711PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygZdzvcj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygZdzvcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D105B1F00A3A;
	Wed, 29 Jul 2026 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785341862;
	bh=YB3NcmqJeNwpGtp8grLN/kj7rLfEcNMrp21qiYAKSTc=;
	h=From:To:Cc:Subject:Date;
	b=ygZdzvcjmqcQYw8t8LsGkwcbqUM/R179dLxPn31QPsu4Gw2A8kv5UlX/UaXMzPXzy
	 7GIOc5MbpxttOhzgD7cINfEPMrWf94/7LJu0Z3e0Itvs+pXtt2TjSeaa6OyG5CJZ2Y
	 OtyIpokEnrG4ttT4M9HrYE2eFBxZSMRNyMpZZmwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.146
Date: Wed, 29 Jul 2026 18:17:24 +0200
Message-ID: <2026072925-catacomb-spring-bece@gregkh>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.146 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile               |    2 +-
 fs/proc/base.c         |   26 ++++++++++++++------------
 kernel/fork.c          |    5 +++--
 mm/madvise.c           |    4 ++--
 mm/process_vm_access.c |    4 ++--
 5 files changed, 22 insertions(+), 19 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.6.146

Lorenzo Stoakes (1):
      mm: refactor mm_access() to not return NULL

