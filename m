Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816996;
	b=SqfwtYZrjnPHHBI8aLCF9HJI5ivpsnFs7dWKfMxjfsIk9CxRYSXuMNuZTtVeavr/3Sgv
	 XNJdvFXjop4/n7Xnm6J4F04KSSUQP6rGhhgt2fMjWMwDPAshtroKkH8n7q92DtOHiHprZ
	 fAKgVK51BBjXE6IS+OiY7qLj7G9fkg2kYJEol90crJkZuEcJtSbrMlkfc2Jo/eaydeG4H
	 ZmnTVgtKh3myKqlESVehbuW+V0XwYszUnzZ00Uz6E1KKJhY9CIY6OoyetMc29Wyn4hHAW
	 3svoTy2RxigRjoz7U4q+MC6vbaHcrwPl+5QoeanTQSjv63KBn4daPgWSjKlLcF08QGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816996;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vmEi1AupdmJ44iVBsgBWUNKnne5KCSXVxXfEHl3xpC8=;
	b=EcJekBo2KFXh+1d/yqKdkFDETKEHP9lLUhnDjDT9KFaoRSVsOeh+6dxuZBQpgNkcjXjM
	 ozmSafz8v4YIRVwGA7SoxNh8tBglh40f/mjfacFTCAAln40ZsUDq5kB8qAl87gnEygX5m
	 ekSUnWVcYFblT1D+wC5auLKlmEu5HRp9/jcVLUn7CFUYHDNTdsMmU0Lr0lreEdWSvd4ul
	 lxHDcoCsjWF4b2arOXBClSOLk4VpwCAJYfwLy2HNJTKLSig3ek0yujksM4rTR9vtbr9Vs
	 FO+Dl2KuCBSikakJtHMkI6HaiDWM0hT9zIYkw3wpPYOuCu53ZqlZpa7pmA5KEvXP0Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="Fys/4Kbi";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D73606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 22:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D73606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Fys/4Kbi
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 77CD720B7166; Fri, 27 Nov 2026 14:03:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77CD720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795816989;
	bh=vmEi1AupdmJ44iVBsgBWUNKnne5KCSXVxXfEHl3xpC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fys/4KbiI1MnpPzH6kA5xf9asCoIqAchJHUv8POs6rbyzFOCOmURUWnYg4VS2Gfjd
	 Oww1beOLftS0Uu4xCArP1lS29gqmQRGEAZlPFbhOD7SMDIaPU8Y719F4PPrk4v4fr6
	 c7/PLHjk/iPNTuPrGHTQjJ3S5uUra85Z3Ohh+DU0=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: feng.tang@linux.alibaba.com,
	horms@kernel.org,
	pabeni@redhat.com,
	patches@lists.linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6 0266/3318] selftests: net: reuseport_bpf_numa: consider cpuless numa node
Date: Fri, 27 Nov 2026 17:03:09 -0500
Message-ID: <20261127220309.2088120-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261118150323.389144313@linuxfoundation.org>
References: <20261118150323.389144313@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch appears to be causing the build to fail. Seems, like commit
f2662ec26b26 ("selftests: kselftest: Create ksft_print_dbg_msg()") is
missing from linux-6.6.y.

BR,
Hamza
