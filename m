Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976160;
	b=D9PDeNiTgDgTgWF2O5aRLB4a4n6knjyKe8QbD89bMKTGhcHK6S7kv0UImTZsyPCrj86v
	 e05tVfgKJaJcVgs8EQMmZKbGRZX+EzvK67t5vf53gXM7LNrh2iyfrkmtHj7ORGWJk3mOO
	 GcuDwV3g1HxZQgz5ekYV8Af14mDYMrrRUrucHThq8kth0XH03e3IroSkLWa3Jc6gOBef/
	 HBZE6NhX1peFQRT1XHv0cw6zmVp6n1KEZY9tUc8Veg/qpoHAnYXnkqwEiK2S5/Z4d6GmL
	 +v978eZt3A2v9FuWxFIDmH2WHwo8cVzylcIMIaTY2me7kckQjXZTc7IqCTI368AeAJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PHyaJQrkTMphdYzmc+rshzaiZTp40YbulP0xbtW1OI8=;
	b=OhCRd/jiBeKk4rUVomWB4mZHP4MCxb+SpoanaSbAHLOuKGwA/rK+D5d/wutHZOMnA7tw
	 NFoijzfbYjn6/J0l/jDJ5nHoGr2BnXuYE7Q+Cb9FroadfpdZBxNMbHvxTF5hW12pTjlkA
	 FKCo226kPkG2XgC/7wd9fdZg/48RCvgc4ezAnU08PNQ67Z/h6hgSY6j75vcqFkFlmQK+Y
	 YTuPNxxYUDN9J4aJwR0aRKSaoOUZ+7nMKWXskb58/IiulytN48dm6FO/uNCoZjLbsVVS3
	 mXZlsZx+0FyuBNdNiWtNBkVYLeYaZy3OXXfNHKt+HfkWelBPdrdQwYnytETLAdNC6wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=e6VbgxFx;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="O7q/mEYv";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415E606A8AB
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9415E606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=e6VbgxFx;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=O7q/mEYv
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI1XOLD3627144
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=PHya
	JQrkTMphdYzmc+rshzaiZTp40YbulP0xbtW1OI8=; b=e6VbgxFxU5xDgnwjTkyK
	mwCjKCZI4ZsVkmuD7cqvdFDXWAgu4q5AjhaA4EJICcEKHypx6gTHmbMUVg/gLv0D
	Hg7x50aBkgdQGzBDP2O+KxmDhN2DhFLrcjqYparniyVSi5bZtKD/Grx57h759o3K
	GdAVvgPrB6+38IDtfj8ErFkeYRn2XRH30u5vhZV5IFmlPT078iKuOuFJ89DcXwNF
	/C4Gst59vVkKp3UiIhxTCAsVctl651ffqcG7h34RnVHg+32iyW7bZCCM31FjmyBW
	Gtdaj9h+qqfYMfG8nWwMP8Bv+PS569l7RtMcisTZyz85UMKILg7UVn3K5qKBMrDL
	lQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu79gcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:29:12 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f559420f3so76122685a.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 20:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794976152; x=1795580952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHyaJQrkTMphdYzmc+rshzaiZTp40YbulP0xbtW1OI8=;
        b=O7q/mEYvxoowFx5QUeosMae8Q4AQg4mpwUgBEaGydRKaMpaNm46IP8puVbzjjWM95K
         Tjl4zofAbu++ThMKdGwInv3CVqg1q5rGLwCf9FRJU2WHZplijGSGv/Plg1NCz8FycAMi
         TDGfxUVOcj0PA5QipuYGI6fR8+3W18QEXJkbhYIwhU1umh+gICsQzJAIRuERE2HbrD1T
         lP5LrYQTJnWBToS/OqkqKzELpT3c4upNIA3Q0at3glu8tmQxROw8TicnRVvy2D9AoTtG
         uH21r0NTyKg6gEUvBfKp0Ra4SA9Jcg4jeR5gGh3pJ1KkDU+x1G9eK+prpbtRoUz8purz
         fcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794976152; x=1795580952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHyaJQrkTMphdYzmc+rshzaiZTp40YbulP0xbtW1OI8=;
        b=VzBfvRf5ux8w+PcKcPhnLb6T5ZQ9MXyPyO15y9lG98lkj/LAYJKMIY7Ly4kiL7pvFI
         K5Oe4H3akuUfpAkQiir65T08Bx1WBioRK7EspmB805NohqobdAq79Ri4dmZr3V/x2W7g
         /NazgsgeGwNh6vUlJqcGOe6szcde0qPcgXffT3VFT8oCkOcro0rxF6xEqS5yHAE0/wX2
         YAWnTJHxkYhGcmf/UasGCd5v950Q0ismyi5+s2qjwGTbxlYye6GSR9WmCzRhrs8+0C6C
         ESHycXoTmJ83CiaylLPrICiLzRNs/SfkCzO8mw3gKObut8ussbgsAx/FTadtO8q3a9Gm
         qpCQ==
X-Forwarded-Encrypted: i=1; AL+hErHFsSAor9fIWnR6tuBKVSRer/ezXEYA6b/NKwEmhGBZjvKdKKZBteEh/u+0yQvpcUcuLgEFXso=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ztsnrb7kzvkD4lvn9+/tF2DbzqooCg3u4WkK5pzeekezmtzNg
	Bongz08j+dZPjDZN2nMSgvsbtMb2hDGCop45DAHYqAY/1r3iKfpDnZfcDzFHQEBLe1ez+PcTU2m
	ykxKYHvuEoGEIBalTeDMNV7qT/BJcmhZZqVBEAMfVbkMLR0wqwcEpSw==
X-Gm-Gg: AYBFou0gRW/n9Y02OzcQEiHtVD8Pe1YaiJYybMHWz53QDOyMquOKaPHXm/6BHs6wRRf
	UDGirLx26t/cMKrNNeE/TVuGwZMuNlFjS5LyqhP5J46J2zt94MCYdv2UO4Sh/RoeiPQ/yctEAyt
	MoNpBOiY70/jEXKszTz4ZEsOPqXTX1GlDVkUtiB2Rx7LqduTr7PVfVUhA1ZDsTFuuzGxpUM609v
	4JmKEa4uNLM5HkewT2FQW5Npdj4lUv/8p1H7U6NTfOxw3W3AaYZFBOmud3ID5XEea0zfR3dgCez
	0WeYdudRER5tHsWFAnOzC15mEwtdlqt/al9YztigV0Pf4cgp32w5qyTaVSdBRrf6cS3sGyDDPT1
	WwTeHcvKbQc2crwOKg+2NZKp57KPq0CMafsmoInyJTrN+urDYcEYuTszlKHIlEsrWWz6dIzSzRw
	UiZT3odJkVnZlK8vFlCg==
X-Received: by 2002:a05:620a:460b:b0:949:7781:6a2a with SMTP id af79cd13be357-9499963337bmr333454785a.63.1794976152024;
        Tue, 17 Nov 2026 20:29:12 -0800 (PST)
X-Received: by 2002:a05:620a:460b:b0:949:7781:6a2a with SMTP id af79cd13be357-9499963337bmr333450685a.63.1794976151524;
        Tue, 17 Nov 2026 20:29:11 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b743a8bsm89678085a.17.2026.11.17.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:29:11 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 23:28:42 -0500
Subject: [PATCH v3 2/9] userfaultfd: refuse UFFDIO_MOVE into a non-present
 huge destination PMD
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-uffd-state-fixes-v3-2-b617009d1a4a@columbia.edu>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
In-Reply-To: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794976146; l=2698;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=K0o38pzaMy6QRMMEYRQIJRke0A/nk0J4G+lixSN+sNs=;
 b=340uovLCj4ITRL89ZbsJjjWvkIqBwYm45eDArEoJS/iGZuCtoRxnsfUX1Y97twSamX4VEReXZ
 wqarjnM1+4PBdX8UCgZ5F+jzKyJeOHcxUfjhSKWfMjTuYQYnGIpzg6A
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=LvgHWXdc c=1 sm=1 tr=0 ts=6afd2998 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=tHa68p0SAAAA:8 a=n7zxJ9EK30Z5vFJJ7y0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-ORIG-GUID: 3HHJZwxUMwSX8uLRMzq2wvOi1LSef9Xj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX/gFhM9mGFTj9
 JjsttXmzk84o41UsHUN2Bk79hY1VNDZ039fgaRrJ0jMVLW+cb/VEHEougdp+dqEHhM2gAW2geyL
 fZsjExv45sAUzl2aTsWOD3Kz8Zvq+Ak3ybI7gitGuj5Z2N4jXajS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfXy6NRQpqtIwi3
 HG4vIezdwOVIJ/Br7EBnnPngypdwuMdeNqEqW7AJzKkFeZDnk0EtCR0H5yb59dYsAP84laagE6W
 BneDPuWY7mRj4zc+2mWCdsRZ7JQ7attf0orJUw/LKEKCEN0vzm+mIet7hxZXKz1eIuKiuUE5fu2
 QUs8mwTOtF36KrI3mX6/keU3T71vjnqHb9XpaUzLGyyw2zSLvJccVPVolRFpv7GZt1BPMynfc/N
 +xkmZdSg/5Y1BGQwb3kkpHfScsTOy1u/8urU4wAjRKtGjl2O3aduIIPHEu2WrdT0lMJH3DoVw84
 62lByItNpYZPZhC+FC7TyPu9iYozWfXgKxxOhWzpdMwgVBx/3/lxH07IwMbcXo9BC9YqkO990r6
 bYS4ypsh+KaqTR2MABCEJjMxaJL8CvlpkDEEx7B9Az4r8ELvH5ZBIA55o+Y2tt0oTbKalhLOXfy
 lv8gq9LDSB4vFVkpuwg==
X-Proofpoint-GUID: 3HHJZwxUMwSX8uLRMzq2wvOi1LSef9Xj
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11969
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 malwarescore=0 phishscore=0 lowpriorityscore=10
 priorityscore=1501 adultscore=0 bulkscore=10 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180017

move_pages() refuses to move into a destination PMD that already maps a
THP, but checks for that with pmd_trans_huge(), which is only true for a
present THP. A device-private THP or a THP under migration is a PMD
softleaf entry and is not refused.

The destination PMD is then treated as if it pointed to a PTE table. It
is not empty, so pte_alloc() leaves it alone, and move_pages_ptes()
fails to map a PTE table from it and returns -EAGAIN. move_pages()
retries on -EAGAIN, with both VMA read locks held. If the source is a
THP, it is split first for nothing.

For a THP under migration, the loop ends once the migration finishes.
A device-private THP can remain in device memory indefinitely, so the
caller of UFFDIO_MOVE hangs until it receives a fatal signal, and
anything in the mm that needs to write-lock one of the VMAs blocks along
with it. This requires a driver that migrates THPs to device memory.

To fix it, check the destination with pmd_is_huge(), which is true for
a present THP and for a PMD softleaf entry. UFFDIO_MOVE now fails with
-EEXIST in these cases, as it already does for a present THP.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/userfaultfd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e787e9a3ea29..0435ceafe750 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2021,12 +2021,13 @@ static ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		dst_pmdval = pmdp_get_lockless(dst_pmd);
 		/*
-		 * If the dst_pmd is mapped as THP don't override it and just
-		 * be strict. If dst_pmd changes into TPH after this check, the
-		 * move_pages_huge_pmd() will detect the change and retry
-		 * while move_pages_pte() will detect the change and fail.
+		 * If the dst_pmd is a huge leaf, present or not, don't
+		 * override it and just be strict. If dst_pmd changes into a
+		 * leaf after this check, move_pages_huge_pmd() will detect the
+		 * change and retry while move_pages_ptes() will fail to map
+		 * the PTE table and the next iteration will see the leaf.
 		 */
-		if (unlikely(pmd_trans_huge(dst_pmdval))) {
+		if (unlikely(pmd_is_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}

-- 
2.39.5

