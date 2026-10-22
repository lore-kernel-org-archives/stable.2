Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792630275;
	b=MDfi8furxZcaYjU3Nzt574zZPo7uJ740w+vVG2M4YaRB/wjCU3FW6Jq5AaBhS9rHf1vG
	 sLILedvufjzUVAjJ575DMVO1u93Q9SGQ9OMUvi2amkPzEX44DrSMjuC+DS3JW8je5jct9
	 Dh65DwlArooUfKeTtLlGETxSRna/f+d07ZLHe6d5j+LvxjwUdRvJ85wf15gkCGpWdeppd
	 5EVgO672OATj344dg6V3aWK+EjyRa7i8dRzPU6vnWbKeljchPagzVdGlMGjNNfsI9BlvQ
	 sy3j7RpDIRIoDfXoGgbnW5nG6iAPb5YyF/vuzrXgnTQsMRTfsZ2RFcp11pMHEQzHNlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792630275;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YnSPPvpmQOUJ4waeQ3xaQjMx8WMQI2DxpZDvU9ftVls=;
	b=rT+fP+86Mf2WXHQsM3g5koL5eQFgUFFLtvR5c+4VZ/gHU5G7MHmTu1r/861yWok2TZf+
	 FFXz6UdQpSScsUY4jEGSpaMluneK3gY4VDG6uubWi1kzXXe2NSX9Ubr3d3RDu1r4fqSXp
	 tBO/MAB15cmAJbenjI6q2l7ZQFrcdmILxTS5h+xB7uayPjusdExyrZTaLcsVHCaJlVahA
	 3ORE74WLDyAmbqXCO488N1qNLchVEvPyF5xD1S39wkS/dKUy4FJ5qSmX2XOCZCXZNxIeE
	 CenuoPftwJn7CdZOyRt80Ls2dpzjc5z12XGjWX+Pjfznza3rQxC3yF5z8dctX6Zp3kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xamMX0f6;
	arc=none smtp.remote-ip=95.215.58.111
Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C18606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 00:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C18606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xamMX0f6
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YnSPPvpmQOUJ4waeQ3xaQjMx8WMQI2DxpZDvU9ftVls=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792630272; v=1; x=1793235072;
 b=xamMX0f6ZQj1tvTfxXMnc0w8Rx8uQHBBVHJg3ITje8SNSY/cKSWjjn/RC0DHWaFpw4XbyUFD
 Zp9eT0ZhFypfDN9ICNGIklCZSBVU0EGruN6Nk5fzk7UoyKdAPKWULJOSJ4RL2f8bBYX6eL8lpVl
 iAeN0ENRLoAjyb72wUic1PAk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3fa99ff370979236;
	Thu, 22 Oct 2026 00:51:12 +0000
X-Mizu-Trace-ID: 3fa99ff370979236
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: samarth.colleges@gmail.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/ksm: keep soft-dirty when merging a page
Date: Thu, 22 Oct 2026 08:51:02 +0800
Message-ID: <20261022005102.29011-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261021182157.1873726-1-samarth.colleges@gmail.com>
References: <20261021182157.1873726-1-samarth.colleges@gmail.com>
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


On Wed, Oct 21, 2026 at 11:21:57AM -0700, Samarth Narang wrote:
>replace_page() maps the KSM page with a PTE built from scratch, so the
>soft-dirty bit of the PTE it replaces is lost. A page written since
>"clear_refs 4" then no longer shows as soft-dirty once it is merged, and
>a soft-dirty based dumper treats it as unchanged.
>
>Copy the soft-dirty bit from the original PTE to the new PTE.
>
>Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
>---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
