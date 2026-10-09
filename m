Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21463F1056;
	Fri,  9 Oct 2026 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585411; cv=none; b=Buq0TK+SfAu71Nf7N73P/1Fxz/Fl++N5DHC5qukDTGII7/6IE2teH7xe4ruA5lIyYoT9unriCYjHK/ORbZRpb0/m/7C2/NWpB+yfTEeNVYssN3KUA0NM9xr6dQruXxQA8SpgKCxMMOLskJVtTg2iZWfAWfr1/7Q5HYNBl7PEh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585411; c=relaxed/simple;
	bh=kVotqgVqw+iPzGvtTlz7PfnfIqCMUIeI6scp7He+8DI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MIm1pJhsmIY7eb2SBqZTldO5NnJSZkOMAxg7eRZ7sEy6jbSVPRbGXw+yXOkmhLrwtKSYWwTztW2MTHWWtAIrCUU0EJSnc4Yc3XRDdhhiGU8we3dYkY3VX2Mj8VcuPbzz7oZtgR92QlxSjxuQlYN9mw8YiYd9G6MM6Nc1jXFyCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JBtlNufi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JBtlNufi"
Received: from [IPV6:2607:fb91:150e:549f:d0:596:baf6:82e4] (unknown [172.56.108.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AB3520B7168;
	Fri,  9 Oct 2026 15:36:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AB3520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791585407;
	bh=kVotqgVqw+iPzGvtTlz7PfnfIqCMUIeI6scp7He+8DI=;
	h=Date:From:Subject:To:Cc:From;
	b=JBtlNufiZj0CqZ25UJbwDp8DlkCCMW3nib0MKD92iphcMPMQoKk6RZbIeHLVEA86x
	 /Ge3NWe/4nKp5KK62DZLoIzzZwNR5gbXUiigUKYNtIFvKTL6pnadBfma2HMqwZ9n9h
	 AYLaLPe0b9vy8TjeAhFYf2mvFPQznLI0u8amgxZQ=
Message-ID: <899bd843-fd19-418e-8913-91bfb6e760a2@linux.microsoft.com>
Date: Fri, 9 Oct 2026 15:36:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Rachel Menge <rachelmenge@linux.microsoft.com>
Subject: Request backport of bf5a54bc0e3d to 6.18.y
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi stable team,

Please consider applying the following upstream commit to 6.18.y:

bf5a54bc0e3d8962474fcd611f1266eba036232f
doc/netlink: netlink-raw: Add max check

The 6.18.y tree contains these related changes:

2fd0880f0272 ("net: reject oversized tx_queue_len at netlink parse time")
982c7f66c041 ("neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.")

Those changes add checks.max to the rt-link.yaml and rt-neigh.yaml
Netlink specifications. However, the 6.18.y version of
Documentation/netlink/netlink-raw.yaml neither defines len-or-limit nor
permits checks.max.

I found this while building YNL from v6.18.55. I reproduced the failure
against the unmodified v6.18.55 tag with:

   make -C tools/net/ynl/generated rt-link-user.h

YNL code generation fails JSON schema validation because the rt-link and
rt-neigh specifications use checks.max while netlink-raw.yaml rejects that
property:

   jsonschema.exceptions.ValidationError:
   Additional properties are not allowed ('max' was unexpected)

The requested upstream commit updates only the build-time YAML schema. It
does not change kernel runtime behavior.

I also checked 6.1.y, 6.6.y, 6.12.y, and 6.19.y. Those branches do not
contain the rt-link.yaml and rt-neigh.yaml checks.max additions that create
this mismatch, so this request is limited to 6.18.y.

Thanks,
Rachel Menge
